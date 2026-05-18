# mise setup

# Disable hook-based activation from homebrew default to prevent complications with direnv
set -gx MISE_FISH_AUTO_ACTIVATE 0

set MISE_SHIMS_DIR {$HOME}/.local/share/mise/shims
if test -d "$MISE_SHIMS_DIR"
    fish_add_path -g -m (mise bin-paths) $MISE_SHIMS_DIR
end
