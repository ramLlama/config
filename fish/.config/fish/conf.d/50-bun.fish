# bun setup

# bun
set BUN_BIN_DIR {$HOME}/.bun/bin
if test -d "$BUN_BIN_DIR"
   fish_add_path -g -m "$BUN_BIN_DIR"
end