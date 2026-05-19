---
description: Review code changes for issues
argument-hint: '[branch|files...]'
---

Review code changes for bugs, logic errors, security issues, performance problems, breaking changes, and missing tests.
Skip style and formatting — assume linting handles those.

Arguments: $@

Determine what to review based on the arguments above:

- No arguments and staged changes exist → review staged changes (`git diff --cached`)
- No arguments and no staged changes → review working directory changes (`git diff`)
- Branch name → compare current branch against that branch
- File paths → review only those files

For each issue found: state the problem, its impact, and a suggested fix. Group by severity: critical, warning, info. If
no issues are found, confirm the changes look good.
