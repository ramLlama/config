# MacOS-specific setup

# Use homebrew as test of "am I on MacOS?"
set HOMEBREW_BIN_DIR /opt/homebrew/bin
if test -d $HOMEBREW_BIN_DIR
    fish_add_path $HOMEBREW_BIN_DIR
    brew shellenv fish | source

    # Add LLVM paths if installed
    if test -d $HOMEBREW_PREFIX/opt/llvm
        fish_add_path $HOMEBREW_PREFIX/opt/llvm/bin
        set -x LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
        set -x CFLAGS "-I/opt/homebrew/opt/llvm/include"
        set -x CPPFLAGS "-I/opt/homebrew/opt/llvm/include"
    end

    # we're in homebrew, add relevant gnubin directories
    for GNU_BIN_DIR in \
        $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin \
        $HOMEBREW_PREFIX/opt/make/libexec/gnubin
        if test -d $GNU_BIN_DIR
            fish_add_path $GNU_BIN_DIR
        end
    end

    # Prefix standard header and library paths
    set -x CPATH $HOMEBREW_PREFIX/include {$CPATH}
    set -x LIBRARY_PATH $HOMEBREW_PREFIX/lib {$LIBRARY_PATH}

    # terminfo
    set -x TERMINFO_DIRS {$HOMEBREW_PREFIX}/opt/ncurses/share/terminfo:{$TERMINFO_DIRS}
end