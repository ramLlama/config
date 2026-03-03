# Misc Style Guide

The `misc/` package contains dotfiles that don't belong to any other stow package.

## When to Add Here

Add a file to `misc/` only when it has no natural home in another package and is a single standalone dotfile deployed directly to `$HOME`.

## Current Files

- **`.gitignore_global`** — Global git ignore patterns. Standard gitignore format. Keep focused on build artifacts, editor temporaries, and LaTeX outputs rather than project-specific patterns.
- **`.latexmkrc`** — Configuration for `latexmk`. Uses Perl assignment syntax.

## Conventions

- Keep the package small. If a new tool grows beyond one or two config files, create a dedicated stow package for it.
- No subdirectory structure needed unless the target path requires it.
