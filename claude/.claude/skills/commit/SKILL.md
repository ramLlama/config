---
name: commit
description: Stage and commit changes using Conventional Commits. Pass --staged to only commit already-staged files, otherwise stages and commits all changes.
argument-hint: [--staged] [--no-claude-coauthor]
allowed-tools: Bash(git *)
---

Commit the current changes.

- **Scope**: with `--staged`, commit only what is already staged. Otherwise stage all changes, adding files by name (not `git add -A`). Skip anything that looks like secrets and tell me.
- **Message**: Conventional Commits, `<type>(<scope>): <description>`. Types: `feat`, `fix`, `refactor`, `test`, `docs`, `build`, `ci`, `perf`. Never `chore`. Imperative, lowercase, no trailing period, subject ≤ 72 chars. Match the repo's recent log style. Add a body only when the why isn't obvious from the diff.
- **Trailer**: end with `Co-Authored-By: Claude <noreply@anthropic.com>` unless `--no-claude-coauthor` is passed.

Show the resulting commit with `git log --oneline -1`.
