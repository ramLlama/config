# Rassumfrassum Style Guide

Rassumfrassum is a custom LSP aggregator tool. This package configures its language server definitions.

## File Structure

One Python file per language: `<language>.py`. Example: `python.py`, `typescript.py`.

## Module Structure

Each language file must export a `servers()` function that returns a list of server command lists:

```python
import pathlib

THIS_DIR = pathlib.Path(__file__).parent

def servers():
    return [
        ["server-binary", "arg1"],
        ["another-server", "--config", (THIS_DIR / "config-file.toml").as_posix(), "serve"],
    ]
```

Key conventions:
- Use `THIS_DIR` for paths relative to the config directory (avoids relying on cwd)
- Use `.as_posix()` when building path strings for command arguments
- Each server is a list of strings (command + arguments)
- No extra imports beyond `pathlib`

## Adding a Language

1. Create `<language>.py` with a `servers()` function.
2. If the language needs a linter config, add `default-<tool>.toml` alongside it and reference via `THIS_DIR`.

## Shared Config Files

Tool-specific config files (e.g., `default-ruff.toml`) live in the same directory as the language files. Reference them via `THIS_DIR / "filename"` in the Python module.
