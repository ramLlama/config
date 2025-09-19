# rust setup

# cargo
set CARGO_BIN_DIR {$HOME}/.cargo/bin
if test -d "$CARGO_BIN_DIR"
   fish_add_path "$CARGO_BIN_DIR"
end