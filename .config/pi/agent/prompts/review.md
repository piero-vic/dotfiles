---
description: Review code changes for issues
argument-hint: '[target]'
---

Review code changes for bugs, logic errors, security issues, performance problems, breaking changes, and missing tests.
Skip style and formatting — assume linting handles those.

Determine what to review based on the following target: `${1:-staged}`

- `staged` → review staged changes (`git diff --cached`) only. If no staged changes exist, tell the user and suggest
  staging files first — do **not** fall back to unstaged changes.
- `branch` → compare current branch against that branch (`git diff <branch>...HEAD`)
- File paths → review only those files (use `git diff -- <paths>` for tracked changes or read the files directly)

**Never review unstaged working-directory changes** (`git diff` without `--cached`). Reviewing uncommitted
work-in-progress is unhelpful and noisy — only review changes that are ready (staged or on a branch).

For each issue found: state the problem, its impact, and a suggested fix. Group by severity: critical, warning, info. If
no issues are found, confirm the changes look good.
