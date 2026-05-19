/**
 * Slash Guard - Prevents mistyped slash commands from being sent as user messages.
 *
 * When the user types something starting with `/` that doesn't match any known
 * command, the extension blocks the message and notifies the user, including
 * suggestions if any similar commands are found.
 */
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

/**
 * Built-in interactive commands not returned by pi.getCommands().
 * Hardcoded because pi doesn't yet expose a public API for these.
 * Source: packages/coding-agent/src/core/slash-commands.ts
 */
const BUILTIN_COMMANDS = [
  "settings",
  "model",
  "scoped-models",
  "export",
  "import",
  "share",
  "copy",
  "name",
  "session",
  "changelog",
  "hotkeys",
  "fork",
  "clone",
  "tree",
  "login",
  "logout",
  "new",
  "compact",
  "resume",
  "reload",
  "quit",
];

const MAX_SUGGESTION_DISTANCE = 2;

/**
 * Computes the Levenshtein distance between two strings using dynamic programming.
 *
 * The Levenshtein distance is the minimum number of single-character edits
 * (insertions, deletions, or substitutions) required to change one string into the other.
 *
 * @see https://en.wikipedia.org/wiki/Levenshtein_distance#Iterative_with_full_matrix
 * @see https://leetcode.com/problems/edit-distance/
 */
function editDistance(a: string, b: string): number {
  const dp: number[][] = Array.from({ length: a.length + 1 }, () =>
    new Array(b.length + 1).fill(0),
  );

  for (let i = 0; i <= a.length; i++) {
    dp[i][0] = i;
  }

  for (let j = 0; j <= b.length; j++) {
    dp[0][j] = j;
  }

  for (let i = 1; i <= a.length; i++) {
    for (let j = 1; j <= b.length; j++) {
      const cost = a[i - 1] === b[j - 1] ? 0 : 1;
      dp[i][j] = Math.min(
        dp[i - 1][j] + 1, // deletion
        dp[i][j - 1] + 1, // insertion
        dp[i - 1][j - 1] + cost, // substitution
      );
    }
  }

  return dp[a.length][b.length];
}

function findSimilarCommands(typed: string, commands: string[]): string[] {
  return commands
    .filter((cmd) => editDistance(typed, cmd) <= MAX_SUGGESTION_DISTANCE)
    .sort((a, b) => editDistance(typed, a) - editDistance(typed, b));
}

export default function (pi: ExtensionAPI) {
  pi.on("input", async (event, ctx) => {
    // Don't intercept extension-injected messages
    if (event.source === "extension") {
      return { action: "continue" };
    }

    const text = event.text.trim();
    if (!text.startsWith("/")) {
      return { action: "continue" };
    }

    // No command name after / (e.g. "/" or "/ ") — unknown command
    const cmdName = text.slice(1).split(/\s+/)[0];
    if (!cmdName) {
      ctx.ui.notify("Unknown command: /", "warning");
      return { action: "handled" };
    }

    const knownCommands = pi.getCommands().reduce((set, cmd) => {
      set.add(cmd.name);
      const base = cmd.name.split(":")[0];
      if (base) {
        set.add(base);
      }
      return set;
    }, new Set<string>(BUILTIN_COMMANDS));
    if (knownCommands.has(cmdName)) {
      return { action: "continue" };
    }

    const allCmds = [...knownCommands];
    const suggestions = findSimilarCommands(cmdName, allCmds);

    const suggestedNames = suggestions.map((s) => `/${s}`);
    const msg =
      suggestedNames.length > 0
        ? `Unknown command: /${cmdName}. Did you mean: ${suggestedNames.join(", ")}?`
        : `Unknown command: /${cmdName}`;

    ctx.ui.notify(msg, "warning");
    return { action: "handled" };
  });
}
