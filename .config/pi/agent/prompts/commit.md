---
description: Commit staged files using conventional commits
argument-hint: '[type] [scope]'
---

Commit only currently staged files. If nothing is staged, tell the user and do nothing else — never stage or commit on
your own.

Inspect staged changes with `git diff --cached`. Check recent style with `git log --oneline -5`.

Arguments: $@

Write a conventional commit message: lowercase, imperative mood, no trailing period. Match the style of recent commits
(e.g. casing, detail level, body usage) while keeping the conventional format.

- **Type:** Use the first argument if provided, otherwise infer from the changes (`feat`, `fix`, `docs`, `style`,
  `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`).
- **Scope:** Use the second argument if provided. Otherwise, omit — never infer.
- **Format:** `<type>(<scope>): <description>` or `<type>: <description>`.

Add a body only if context is needed. Mark breaking changes with `!` after type/scope and include a `BREAKING CHANGE:`
footer.

Run `git commit -m "<message>"`. Never use `--all`.
