/**
 * Aliases Extension for Pi
 *
 * Slash-command aliases for built-in commands.
 *
 * Aliases:
 *   /summarize  →  /compact
 *   /exit       →  /quit
 *   /q          →  /quit
 *   /clear      →  /new
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  // /summarize → /compact
  pi.registerCommand("summarize", {
    description: "Manually compact the session context (alias for /compact)",
    handler: async (args, ctx) => {
      ctx.compact(args ? { customInstructions: args } : undefined);
    },
  });

  // /exit → /quit
  pi.registerCommand("exit", {
    description: "Quit pi (alias for /quit)",
    handler: async (_args, ctx) => {
      ctx.shutdown();
    },
  });

  // /q → /quit
  pi.registerCommand("q", {
    description: "Quit pi (alias for /quit)",
    handler: async (_args, ctx) => {
      ctx.shutdown();
    },
  });

  // /clear → /new
  pi.registerCommand("clear", {
    description: "Start a new session (alias for /new)",
    handler: async (_args, ctx) => {
      await ctx.newSession();
    },
  });
}
