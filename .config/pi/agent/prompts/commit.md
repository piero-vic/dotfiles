---
description: Commit staged files using conventional commits
---

Commit only the currently staged files. If nothing is staged, ask the user what to stage first — do not stage or commit
on your own.

Inspect the staged changes with `git diff --cached`. Check `git log --oneline -5` for existing commit style.

Write a conventional commit message in lowercase, imperative mood, no trailing period.

- **Type:** Use `$1` if provided, otherwise infer the appropriate type (`feat`, `fix`, `docs`, `style`, `refactor`,
  `perf`, `test`, `build`, `ci`, `chore`, `revert`).
- **Scope:** Include scope `$2` if provided. If not provided, omit scope entirely — do not infer one.
- **Format:** `<type>(<scope>): <description>` or `<type>: <description>` (no scope).

Add a body if context is needed. Mark breaking changes with `!` after the type/scope and include a `BREAKING CHANGE:`
footer.

Run `git commit -m "<message>"`. Do not use `--all`.
