# rust setup

# cargo
set CARGO_BIN_DIR {$HOME}/.cargo/bin
if test -d "$CARGO_BIN_DIR"
   fish_add_path -g -m "$CARGO_BIN_DIR"
end