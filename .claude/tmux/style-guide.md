# tmux Style Guide

## File Structure

Single file: `.tmux.conf`. Sections are separated by `###`-style banner comments:

```
##################
# Global Options #
##################

###############
# Keybindings #
###############

###################################
# Color and Format Customizations #
###################################
```

## Key Bindings

**Always `unbind` before `bind`** to make intent explicit:

```
unbind j ; bind j select-pane -L
```

Multi-line bindings use `\` continuation:

```
bind M \
     set-option -g mouse on \;\
     display 'Mouse: On'
```

## Critical Keybinding Facts

- **Prefix: `Ctrl+L`** (not the default `Ctrl+B`)
- **Pane navigation**: `j` = left, `k` = down, `i` = up, `l` = right
- **Splitting**: `v` = vertical split (new pane to the right), `h` = horizontal split (new pane below)
- **Mouse**: `M` = mouse on, `m` = mouse off

Do not change these without considering muscle memory impact.

## Options

Use the shortest correct form:
- `set -g` for global session options
- `setw -g` / `set-window-option -g` for window options
- `set -s` for server options
- `set -sg` for server+global

## Colors and Status Bar

Colors use named tmux colors (`black`, `cyan`, `blue`, `green`, `yellow`). The current status bar uses a cyan/blue/green scheme with powerline-style `▙`/`▟` separators. Maintain this palette when making changes.

## Base Index

Windows and panes are 1-indexed (`base-index 1`, `pane-base-index 1`). Do not change this.
