/**
 * Desktop Notify Extension for Pi
 *
 * Sends a desktop notification using notify-send when the agent finishes
 * its work (agent_end event). Useful for stepping away while waiting for
 * long-running tasks.
 *
 * Commands:
 *   /notify  - Toggle desktop notifications
 *
 * Notifications are disabled by default. Use /notify to toggle.
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { getAgentDir } from "@mariozechner/pi-coding-agent";
import { execFile } from "node:child_process";
import { join } from "node:path";
import { readFile, writeFile } from "node:fs/promises";
import { dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const iconPath = join(dirname(__filename), "pi-logo.svg");

interface Config {
  enabled: boolean;
}

async function readConfig(configFile: string): Promise<Config> {
  try {
    const data = await readFile(configFile, "utf8");
    return JSON.parse(data);
  } catch {
    return { enabled: false };
  }
}

async function writeConfig(configFile: string, config: Config): Promise<void> {
  await writeFile(configFile, JSON.stringify(config, null, 2), "utf8");
}

function sendNotification(
  title: string,
  body: string,
  urgency?: "low" | "normal" | "critical",
): void {
  const args = ["-a", "Pi", "-i", iconPath];
  if (urgency) args.push("-u", urgency);
  args.push(title, body);
  execFile("notify-send", args, (error) => {
    if (error) {
      console.error(
        `[desktop-notify] Failed to send notification: ${error.message}`,
      );
    }
  });
}

async function checkNotifySend(): Promise<boolean> {
  return new Promise((resolve) => {
    execFile("which", ["notify-send"], (error) => {
      resolve(!error);
    });
  });
}

export default function desktopNotify(pi: ExtensionAPI) {
  const configFile = join(getAgentDir(), "desktop-notify.json");
  let enabled = false;
  let notifySendAvailable = false;

  // Restore state on session start
  pi.on("session_start", async () => {
    const config = await readConfig(configFile);
    enabled = config.enabled;
    notifySendAvailable = await checkNotifySend();
  });

  // Send notification when agent finishes
  pi.on("agent_end", async (event, ctx) => {
    if (!enabled || !notifySendAvailable) return;

    const lastAssistant = event.messages
      .toReversed()
      .find((m) => m.role === "assistant");
    if (!lastAssistant) return;

    const sessionName = ctx.sessionManager.getSessionName();
    const model = ctx.model;

    const title = sessionName ? `Pi — ${sessionName}` : "Pi";
    const label = model ? `${model.provider}/${model.id}` : "agent";

    switch (lastAssistant.stopReason) {
      case "stop":
        sendNotification(title, `Done (${label}) — ready for input`);
        break;
      case "length":
        sendNotification(
          title,
          `Hit token limit (${label}) — response may be incomplete`,
          "low",
        );
        break;
      case "error":
        sendNotification(
          title,
          `Error (${label}) — needs attention`,
          "critical",
        );
        break;
      default:
        // Omit "aborted" and "toolUse"
        break;
    }
  });

  // /notify command — toggle notifications
  pi.registerCommand("notify", {
    description: "Toggle desktop notifications",
    handler: async (_args, ctx) => {
      const available = await checkNotifySend();
      if (!available) {
        ctx.ui.notify(
          "notify-send not found — install libnotify to use desktop notifications",
          "error",
        );
        return;
      }

      enabled = !enabled;
      await writeConfig(configFile, { enabled });
      const status = enabled ? "enabled ✓" : "disabled ✗";
      ctx.ui.notify(`Desktop notifications ${status}`, "info");
    },
  });
}
