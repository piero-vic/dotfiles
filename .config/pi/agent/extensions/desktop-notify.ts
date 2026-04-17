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

function sendNotification(title: string, body: string): void {
  execFile("notify-send", ["-a", "Pi", title, body], (error) => {
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
  pi.on("agent_end", async (_event, ctx) => {
    if (!enabled || !notifySendAvailable) return;

    const sessionName = ctx.sessionManager.getSessionName();
    const model = ctx.model;

    const title = sessionName ? `Pi — ${sessionName}` : "Pi";
    const body = model
      ? `Done (${model.provider}/${model.id}) — ready for input ✓`
      : "Agent finished — ready for input ✓";

    sendNotification(title, body);
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
