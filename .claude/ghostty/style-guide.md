# Ghostty Style Guide

## Config Format

`config` uses `key = value` pairs, one per line. No sections or grouping syntax. Comment with `#`.

## Critical Settings — Do Not Change Without Reason

- **`shell-integration = none`** — Shell integration is intentionally disabled. Do not enable it.
- **`shell-integration-features =`** — Left blank to suppress integration features.
- **`font-family = "IBM Plex Mono"`** — Current preferred font.
- **`window-colorspace = display-p3`** — Required for accurate color on Apple displays.

## Theme

The active theme is `modus-vivendi`, defined in `themes/modus-vivendi`. Theme files use Ghostty's palette format (one `palette = <index>=<hex>` line per color, plus `background` and `foreground`).

To add a new theme: create a file in `themes/` with the theme name as the filename. Reference it in `config` with `theme = <name>`.

## macOS-Specific Settings

Settings like `macos-option-as-alt = true` are macOS-specific. If Linux support is added, these may need guards or a separate config mechanism.
