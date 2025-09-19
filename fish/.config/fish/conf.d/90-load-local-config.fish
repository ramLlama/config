# Load local config

set LOCAL_CONFIG_PATH "$HOME/.config/fish/config.local.fish"
if test -e "$LOCAL_CONFIG_PATH"
   source "$LOCAL_CONFIG_PATH"
end