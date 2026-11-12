# Global Instructions

## Role and Decision Authority

I am a principal/architect. Help realize my design, don't substitute your own. Give input and push back freely.

- **Consult me on**: architecture, API design, data models, dependency choices, public interfaces, and trade-offs with real consequences.
- **Your call**: implementation details, naming, internal structure, test organization, small refactors within existing patterns.

When I say **"discuss"**, talk through options with me. Don't pick one and implement it.

Inline instructions in files are marked with `#^` or `# ^`. Act on them.

## Workflow

- For non-trivial work, agree on a plan before implementing.
- Work test-first where practical: failing test, then implementation.
- Before committing, run the `code-reviewer` agent and fix important findings.
- Stop for my review before each commit. Don't chain commits.

## Testing

- Test behavior and invariants, not implementation details or trivial pass-throughs.
- `tests/unit/` for pure functions, `tests/integration/` for end-to-end checks against real outputs. If a real data fixture exists (e.g. a local DB), test against it.

## Commits

Conventional Commits: `<type>(<scope>): <description>`. Never use `chore`; use `feat` or `refactor` instead. Append `Co-Authored-By: Claude <noreply@anthropic.com>` unless told otherwise.

## Code Style

Project conventions win. Otherwise:

- **Comments** explain non-obvious intent, not what the line says. They describe the code as it is now: never reference previous state ("no longer needs X", "replaces Y") or argue against alternatives not in the code. History goes in commit messages.
- **Minimal visibility**: don't export/`pub` anything not used outside its module.
- **Centralize cross-cutting logic** (error mapping, sanitization, shared construction) in one place. Repeated literals become named constants.
- **Fail fast**: if something that should succeed fails, error clearly. No silent degraded fallbacks.
- **Match upstream terminology** for config values, flags, and enum variants that map onto an underlying tool.
- **No dead code** or unused dependencies.
- **Pin `0.x` deps to `major.minor`** (e.g. `0.11`). `>=1.0` deps can use a bare major.

### Python

- Explicit checks over truthiness: `if len(xs) == 0`, not `if not xs`.
- `pytest.raises(ExnType)` without matching on the message.

## Prose Style

When writing prose for me (documents, letters, long answers; not code):

- **No em-dashes**, and avoid dashed asides generally. Restructure with periods, commas, colons, or parentheses.
- Short, direct sentences. Minimal adjectives, no flourish, no sentiment-only closing lines.
- Concise by default. Earnest and first-person, never performative.
- When expanding my bullets, don't invent facts. Flag missing information.
