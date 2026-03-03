# Claude Stow Package Style Guide

The `claude/` directory is a stow package that deploys to `~/.claude/` (global Claude Code config). Do not confuse it with `.claude/` (the project-level Claude Code config for this repo).

## File Structure

```
claude/.claude/
├── CLAUDE.md           # Global instructions loaded in every Claude Code session
├── settings.json       # Global Claude Code settings
└── agents/             # Per-agent instruction files
    └── <agent-name>.md
```

## CLAUDE.md

The global CLAUDE.md covers:
- **Role** — How Claude should relate to the user
- **Decision Authority** — What requires consultation vs. judgment calls
- **Workflow** — Long-running work cycle, TDD, subagent usage
- **CLAUDE.md Maintenance** — When and how to update this file
- **Code Style** — Language-specific style rules

Keep it concise. If it grows unwieldy, move language/topic sections to separate linked files.

## Agent Files (`agents/<name>.md`)

Each agent file documents a custom agent. Include:
- Purpose and trigger conditions
- Step-by-step workflow the agent should follow
- Output format and expected deliverables
- Any constraints or gotchas

Name the file after the agent's `subagent_type` identifier.

## settings.json

Minimal JSON. Only add settings that need to deviate from Claude Code defaults. Empty object (`{}`) is valid.
