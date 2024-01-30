# Use these settings for Modus Vivendi. Only works on 24bit color terminals
set -Ux fish_term24bit 1


# Color indexes
# black
set -Ux fish__colorindex_0 000000
set -Ux fish__colorindex_8 595959

# red
set -Ux fish__colorindex_1 ff8059
set -Ux fish__colorindex_9 ef8b50

# green
set -Ux fish__colorindex_2 44bc44
set -Ux fish__colorindex_10 70b900

# yellow
set -Ux fish__colorindex_3 d0bc00
set -Ux fish__colorindex_11 c0c530

# blue
set -Ux fish__colorindex_4 2fafff
set -Ux fish__colorindex_12 79a8ff

# magenta
set -Ux fish__colorindex_5 feacd0
set -Ux fish__colorindex_13 b6a0ff

# cyan
set -Ux fish__colorindex_6 00d3d0
set -Ux fish__colorindex_14 6ae4b9

# white
set -Ux fish__colorindex_7 bfbfbf
set -Ux fish__colorindex_15 ffffff

# Color Names
# black
set -Ux fish__colorname_black "$fish__colorindex_0"
set -Ux fish__colorname_brblack "$fish__colorindex_8"

# red
set -Ux fish__colorname_red "$fish__colorindex_1"
set -Ux fish__colorname_brred "$fish__colorindex_9"

# green
set -Ux fish__colorname_green "$fish__colorindex_2"
set -Ux fish__colorname_brgreen "$fish__colorindex_10"

# yellow
set -Ux fish__colorname_yellow "$fish__colorindex_3"
set -Ux fish__colorname_bryellow "$fish__colorindex_11"

# blue
set -Ux fish__colorname_blue "$fish__colorindex_4"
set -Ux fish__colorname_brblue "$fish__colorindex_12"

# magenta
set -Ux fish__colorname_magenta "$fish__colorindex_5"
set -Ux fish__colorname_brmagenta "$fish__colorindex_13"

# cyan
set -Ux fish__colorname_cyan "$fish__colorindex_6"
set -Ux fish__colorname_brcyan "$fish__colorindex_14"

# white
set -Ux fish__colorname_white "$fish__colorindex_7"
set -Ux fish__colorname_brwhite "$fish__colorindex_15"

# Set colors
set -Ux fish_color_autosuggestion "$fish__colorname_bryellow"
set -Ux fish_color_cancel "\x2dr"
set -Ux fish_color_command "$fish__colorname_blue"
set -Ux fish_color_comment "$fish__colorname_red"
set -Ux fish_color_cwd "$fish__colorname_green"
set -Ux fish_color_cwd_root "$fish__colorname_red"
set -Ux fish_color_end "$fish__colorname_green"
set -Ux fish_color_error "$fish__colorname_brred"
set -Ux fish_color_escape "$fish__colorname_brcyan"
set -Ux fish_color_history_current "\x2d\x2dbold"
set -Ux fish_color_host "normal"
set -Ux fish_color_host_remote "$fish__colorname_yellow"
set -Ux fish_color_normal "normal"
set -Ux fish_color_operator "$fish__colorname_brcyan"
set -Ux fish_color_param "$fish__colorname_cyan"
set -Ux fish_color_quote "$fish__colorname_yellow"
set -Ux fish_color_redirection "$fish__colorname_cyan\x1e\x2d\x2dbold"
set -Ux fish_color_search_match "$fish__colorname_bryellow\x1e\x2d\x2dbackground\x3d$fish__colorname_brblack"
set -Ux fish_color_selection "$fish__colorname_white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3d$fish__colorname_brblack"
set -Ux fish_color_status "$fish__colorname_red"
set -Ux fish_color_user "$fish__colorname_brgreen"
set -Ux fish_color_valid_path "\x2d\x2dunderline"
set -Ux fish_key_bindings "fish_default_key_bindings"
set -Ux fish_pager_color_completion "normal"
set -Ux fish_pager_color_description "$fish__colorname_yellow\x1e\x2di"
set -Ux fish_pager_color_prefix "normal\x1e\x2d\x2dbold\x1e\x2d\x2dunderline"
set -Ux fish_pager_color_progress "$fish__colorname_brwhite\x1e\x2d\x2dbackground\x3d$fish__colorname_cyan"
set -Ux fish_pager_color_selected_background "\x2dr"
