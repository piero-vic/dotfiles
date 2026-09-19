import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import {
  type AutocompleteItem,
  type AutocompleteProvider,
  type AutocompleteSuggestions,
  fuzzyFilter,
} from "@earendil-works/pi-tui";

type KataIssue = {
  short_id: string;
  title: string;
  status: string;
  labels?: string[];
};

const MAX_ISSUES = 200;
const MAX_SUGGESTIONS = 20;
const LOAD_TIMEOUT_MS = 5_000;
const CACHE_TTL_MS = 30_000;

export default function (pi: ExtensionAPI): void {
  pi.on("session_start", async (_event, ctx) => {
    type IssueCache = {
      value?: KataIssue[];
      loadedAt: number;
      pending: Promise<KataIssue[] | undefined> | undefined;
    };

    const cache: IssueCache = { loadedAt: 0, pending: undefined };

    async function loadIssues(): Promise<KataIssue[] | undefined> {
      const result = await pi.exec(
        "kata",
        ["list", "--status", "open", "--limit", String(MAX_ISSUES), "--json"],
        { cwd: ctx.cwd, timeout: LOAD_TIMEOUT_MS },
      );
      if (result.code !== 0) return undefined;
      try {
        const parsed = JSON.parse(result.stdout) as { issues?: KataIssue[] };
        return parsed.issues ?? [];
      } catch {
        return undefined;
      }
    }

    function getIssues(): Promise<KataIssue[] | undefined> {
      const now = Date.now();

      if (cache.value && now - cache.loadedAt < CACHE_TTL_MS) {
        return Promise.resolve(cache.value);
      }
      if (cache.pending) return cache.pending;

      // Cache only on success; on failure leave the previous cache in place so
      // the next keystroke retries.
      cache.pending = loadIssues().then((issues) => {
        cache.pending = undefined;
        if (issues !== undefined) {
          cache.value = issues;
          cache.loadedAt = now;
        }
        return issues;
      });

      return cache.pending;
    }

    ctx.ui.addAutocompleteProvider((current: AutocompleteProvider) => ({
      triggerCharacters: ["#"],
      async getSuggestions(
        lines,
        cursorLine,
        cursorCol,
        options,
      ): Promise<AutocompleteSuggestions | null> {
        const beforeCursor = (lines[cursorLine] ?? "").slice(0, cursorCol);
        const match = beforeCursor.match(/(?:^|[ \t])#([A-Za-z0-9]*)[ \t]*$/);
        if (!match) {
          return current.getSuggestions(lines, cursorLine, cursorCol, options);
        }

        // We own this `#` token; don't fall back to file/slash completion.
        if (options.signal.aborted) return null;
        const issues = await getIssues();
        if (options.signal.aborted || !issues || issues.length === 0) {
          return null;
        }

        const query = match[1] ?? "";
        const hashIndex = beforeCursor.indexOf("#", match.index ?? 0);
        const prefix = beforeCursor.slice(hashIndex);
        const items = filterIssues(issues, query);
        if (items.length === 0) return null;

        return { prefix, items };
      },

      applyCompletion(lines, cursorLine, cursorCol, item, prefix) {
        return current.applyCompletion(
          lines,
          cursorLine,
          cursorCol,
          item,
          prefix,
        );
      },

      shouldTriggerFileCompletion(lines, cursorLine, cursorCol) {
        return (
          current.shouldTriggerFileCompletion?.(lines, cursorLine, cursorCol) ??
          true
        );
      },
    }));
  });
}

function filterIssues(issues: KataIssue[], query: string): AutocompleteItem[] {
  const q = query.trim();
  if (!q) {
    return issues.slice(0, MAX_SUGGESTIONS).map(formatIssueItem);
  }

  const prefixMatches = issues
    .filter((issue) => issue.short_id.toLowerCase().startsWith(q.toLowerCase()))
    .slice(0, MAX_SUGGESTIONS);
  if (prefixMatches.length > 0) {
    return prefixMatches.map(formatIssueItem);
  }

  return fuzzyFilter(
    issues,
    q,
    (issue) =>
      `${issue.short_id} ${issue.title} ${(issue.labels ?? []).join(" ")}`,
  )
    .slice(0, MAX_SUGGESTIONS)
    .map(formatIssueItem);
}

function formatIssueItem(issue: KataIssue): AutocompleteItem {
  const labels =
    issue.labels && issue.labels.length > 0
      ? ` [${issue.labels.join(",")}]`
      : "";
  return {
    value: `#${issue.short_id}`,
    label: `#${issue.short_id}`,
    description: `[${issue.status.toLowerCase()}]${labels} ${issue.title}`,
  };
}
