# config -- Dotfiles Repository

## What This Project Does

This is a personal dotfiles repository managed with GNU Stow. Each top-level directory is a "stow package" that mirrors the file structure it should create under `$HOME`. Running `stow --target=$HOME <package>` symlinks its contents into the home directory.

## Tech Stack

- **GNU Stow** -- symlink farm manager for deploying dotfiles
- **Fish shell** -- primary shell, all shell config is fish (no bash/zsh)
- **macOS and Linux** -- dual platform support
- **Ghostty** -- current primary terminal emulator
- **tmux** -- terminal multiplexer
- **Modus Vivendi** -- preferred dark color theme (used in fish, ghostty)

## Repository Structure

```
config/
├── claude/             # STOW PACKAGE for ~/.claude/ (global Claude Code config)
├── fish/               # Fish shell config (conf.d/, functions/, themes/)
├── ghostty/            # Ghostty terminal config + modus-vivendi theme
├── misc/               # Miscellaneous dotfiles (.gitignore_global, .latexmkrc)
├── rassumfrassum/      # LSP server config for a custom tool (Python, TypeScript)
├── tmux/               # tmux config
├── .claude/            # PROJECT-LEVEL Claude Code settings (not a stow package)
├── .gitignore          # Ignores generated/local files
└── README.md           # One-line description + usage
```

## Key Concepts

### Stow Packages

Every top-level directory (except `.claude/` and `.git/`) is a stow package. The directory structure inside each package mirrors the path relative to `$HOME`. For example:

- `fish/.config/fish/conf.d/50-editor.fish` gets symlinked to `~/.config/fish/conf.d/50-editor.fish`
- `tmux/.tmux.conf` gets symlinked to `~/.tmux.conf`

### The `claude/` Stow Package

The `claude/` directory is special -- it is a stow package that deploys the user's **global** Claude Code instructions (`~/.claude/CLAUDE.md`, `~/.claude/agents/`, `~/.claude/settings.json`). Do not confuse it with `.claude/` (the project-level Claude settings directory).

### Fish Shell conf.d Numbering Convention

Fish config snippets in `conf.d/` use a numeric prefix to control load order:

- **50-** -- Core setup: tool-specific config, language environments, PATH additions
- **60-** -- Tool integrations that depend on earlier PATH setup (mise)
- **70-** -- Local bin directories added to PATH
- **80-** -- Cleanup passes (deduplicating environment variables)
- **90-** -- Final steps (loading machine-local config)

### Local/Machine-Specific Config

Fish supports a `config.local.fish` file (gitignored) sourced at the end of startup via `90-load-local-config.fish`. This is for machine-specific settings not committed to the repo.

### Color Theme: Modus Vivendi

The current color theme is Modus Vivendi (dark). It is configured in:
- `ghostty/.config/ghostty/themes/modus-vivendi` (palette definition)
- `fish/.config/fish/themes/modus-vivendi-24bit.theme` (fish syntax highlighting colors)

## Development Workflow

### Deploying a Package

```sh
cd /path/to/config
stow --target=$HOME <package-name>
```

For example: `stow --target=$HOME fish`

### Removing a Package

```sh
stow --target=$HOME -D <package-name>
```

### Adding a New Config File

1. Determine the target path relative to `$HOME` (e.g., `~/.config/foo/bar.conf`).
2. Place the file at `<package>/.config/foo/bar.conf` in this repo.
3. Run `stow --target=$HOME <package>`.

## Critical Idiosyncrasies and Gotchas

- **`claude/` vs `.claude/`**: The `claude/` directory is a stow package that deploys to `~/.claude/`. The `.claude/` directory is project-level Claude Code config. They serve completely different purposes.
- **Platform**: This repo is currently for macOS and Linux. The fish config handles macOS-specific setup via `50-mac-os.fish`, which tests for `/opt/homebrew/bin` existence as a proxy for "am I on macOS?".
- **fish_variables is gitignored**: The `fish/.config/fish/fish_variables` file exists in the repo but is listed in `.gitignore`. It should not be committed with changes.
- **tmux prefix is Ctrl+L** (not the default Ctrl+B). Pane navigation uses j/k/i/l (not vim-style h/j/k/l).
- **Ghostty has shell-integration disabled** (`shell-integration = none`).
- **The `rassumfrassum` package** configures LSP servers for a custom tool. Python config uses ty, ruff, and codebook-lsp. TypeScript config uses vtsls and codebook-lsp.
- **bun PATH config has a bug**: In `50-bun.fish`, the variable reference is missing `$` signs (`"BUN_BIN_DIR"` instead of `"$BUN_BIN_DIR"`). This means the bun PATH addition likely does not work.

## Context Files

Per-subdirectory style guides mirror the package structure:

- [fish/style-guide.md](fish/style-guide.md) -- conf.d conventions, PATH management, platform detection
- [tmux/style-guide.md](tmux/style-guide.md) -- keybindings, prefix, section layout
- [ghostty/style-guide.md](ghostty/style-guide.md) -- config format, theme structure, critical settings
- [rassumfrassum/style-guide.md](rassumfrassum/style-guide.md) -- LSP server module conventions
- [misc/style-guide.md](misc/style-guide.md) -- when and how to add files
- [claude/style-guide.md](claude/style-guide.md) -- CLAUDE.md structure, agent files, settings
