# mise setup

set MISE_SHIMS_DIR {$HOME}/.local/share/mise/shims
if test -d "$MISE_SHIMS_DIR"
    fish_add_path $MISE_SHIMS_DIR (mise bin-paths)
end