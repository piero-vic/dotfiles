/**
 * Pi Response Time Extension
 *
 * Notifies the user how long the agent took to respond after each turn.
 * Displays a notification with the elapsed time when the agent finishes.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  let startTime: number | null = null;

  pi.on("agent_start", async () => {
    startTime = Date.now();
  });

  pi.on("agent_end", async (_event, ctx) => {
    if (startTime === null) return;
    const elapsed = Date.now() - startTime;
    startTime = null;

    const seconds = elapsed / 1000;
    let formatted: string;
    if (seconds < 60) {
      formatted = `${seconds.toFixed(1)}s`;
    } else {
      const mins = Math.floor(seconds / 60);
      const secs = (seconds % 60).toFixed(0);
      formatted = `${mins}m ${secs}s`;
    }

    ctx.ui.notify(`Response time: ${formatted}`, "info");
  });
}
