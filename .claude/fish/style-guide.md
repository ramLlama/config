# Fish Shell Style Guide

## conf.d File Naming

Files in `conf.d/` use a numeric prefix to control load order:

- **50-** — Core setup: tool config, language environments, PATH additions
- **60-** — Tool integrations that depend on earlier PATH setup (e.g., mise)
- **70-** — Local bin directory additions
- **80-** — Cleanup passes (e.g., deduplicating PATH-like variables)
- **90-** — Final steps (loading machine-local config)

Name files `<number>-<topic>.fish`. The topic should be the tool or concern being configured (e.g., `50-lang-rust.fish`, `50-mac-os.fish`).

## Variable Exports

Use `set -x` for environment variable exports:

```fish
set -x EDITOR editor
set -x LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
```

## PATH Management

Use `fish_add_path` for PATH additions. It handles deduplication and prepends by default:

```fish
fish_add_path $HOMEBREW_BIN_DIR
```

Always guard path additions with an existence check:

```fish
if test -d $SOME_DIR
    fish_add_path $SOME_DIR
end
```

## Platform Detection

macOS is detected by the presence of the Homebrew directory. Do **not** use `uname` or `$os`:

```fish
set HOMEBREW_BIN_DIR /opt/homebrew/bin
if test -d $HOMEBREW_BIN_DIR
    # macOS-specific setup
end
```

## Comments

One brief comment per file explaining its purpose at the top:

```fish
# MacOS-specific setup
```

Add inline comments only for non-obvious steps. Omit comments for self-evident lines.

## Language Environment Files

Language environment files follow `50-lang-<language>.fish`. They set up PATH and environment variables specific to that language toolchain.

## functions/ Directory

Fish functions go in `functions/`. File name must match the function name (Fish convention). Keep functions focused on a single task.

## Machine-Local Config

Machine-specific settings belong in `config.local.fish` (gitignored), sourced by `90-load-local-config.fish`. Do not add machine-specific values to committed files.
