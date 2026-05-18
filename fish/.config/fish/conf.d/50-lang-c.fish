# C/C++ setup

# ccache
set CCACHE_BIN_PATH /usr/lib/ccache
if test -d $CCACHE_BIN_PATH
    fish_add_path -g -m $CCACHE_BIN_PATH
end