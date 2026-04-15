---
name: commit
description: Stage and commit changes using Conventional Commits. Pass --staged to only commit already-staged files, otherwise stages and commits all changes.
argument-hint: [--staged] [--no-claude-coauthor]
allowed-tools: Bash(git *)
---

Commit the current changes to git. Follow these steps exactly:

## Step 1 — Inspect changes

Run these commands in parallel:

- `git status` — see what is tracked/untracked/staged
- `git log --oneline -10` — learn the commit message style used in this repo

Then, based on the arguments:

- If `$ARGUMENTS` contains `--staged`: run `git diff --staged` to see only staged changes.
- Otherwise: run `git diff HEAD` (or `git diff` + `git diff --staged` together) to see all changes.

## Step 2 — Identify files to commit

- If `--staged` was passed: only commit what is already staged. Do not `git add` anything.
- Otherwise: stage every modified/new file individually by name (do NOT use `git add .` or `git add -A`). Skip files that look like they could contain secrets (`.env`, credentials, private keys, etc.) and warn the user about any you skip.

## Step 3 — Write the commit message

Use [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>(<scope>): <short description>

[optional body]
```

**Allowed types** (never use `chore`):
| Type | When to use |
|------|-------------|
| `feat` | New feature or behaviour |
| `fix` | Bug fix |
| `refactor` | Restructuring without behaviour change |
| `test` | Adding or updating tests |
| `docs` | Documentation only |
| `build` | Build system / dependency changes |
| `ci` | CI/CD pipeline changes |
| `perf` | Performance improvements |

Rules:
- Scope is optional but preferred when the change is clearly scoped to one module/package.
- Short description: imperative mood, lowercase, no trailing period, ≤ 72 chars total for the subject line.
- Add a body only when the *why* is non-obvious from the diff.
- Always append a `Co-Authored-By` trailer to the commit message (see Step 4), unless `$ARGUMENTS` contains `--no-claude-coauthor`.

## Step 4 — Commit

Pass the message via a heredoc to preserve formatting:

By default, include the `Co-Authored-By` trailer after a blank line following the body:

```bash
git commit -m "$(cat <<'EOF'
<type>(<scope>): <description>

<optional body>

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

If `$ARGUMENTS` contains `--no-claude-coauthor`, omit the trailer:

```bash
git commit -m "$(cat <<'EOF'
<type>(<scope>): <description>

<optional body>
EOF
)"
```

After committing, run `git status` to confirm success and show the user the resulting commit with `git log --oneline -1`.
