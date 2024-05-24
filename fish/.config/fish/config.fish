# Temp file for configuration
set TEMP_FILE (mktemp)

##################################
# Add system directories to PATH #
##################################
fish_add_path --append /bin /usr/bin /usr/local/bin /sbin /usr/sbin /usr/local/sbin

#################################
# Add local directories to PATH #
#################################

fish_add_path "$HOME/.local/bin"

###############
# MacOS setup #
###############
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
        set -x LDFLAGS "-L$HOMEBREW_PREFIX/opt/llvm/lib/c++"
    end

    # we're in homebrew, add relevant gnubin directories
    for GNU_BIN_DIR in \
        $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin \
        $HOMEBREW_PREFIX/opt/make/libexec/gnubin
        if test -d $GNU_BIN_DIR
            fish_add_path $GNU_BIN_DIR
        end
    end

    # terminfo
    set -x TERMINFO_DIRS {$TERMINFO_DIRS} $HOME/.local/share/terminfo
end

############################################
# Add various ecosystem-specific bin paths #
############################################
# perl
set PERL_BIN_PATH /usr/bin/core_perl
if test -d $PERL_BIN_PATH
    fish_add_path $PERL_BIN_PATH
end
perl -Mlocal::lib &>/dev/null
if test $status = 0
    eval (perl -Mlocal::lib)
end

# ruby/gem
# only need to set if gem is installed
which gem &>/dev/null
if test $status = 0
    fish_add_path (gem environment gempath | tr ':' '\n' | perl -ne "chomp \$_; if (m|^$HOME/.gem|) { print \$_ . \"\n\"; exit 0; }")/bin
end

# haskell/cabal
set CABAL_BIN_PATH {$HOME}/.cabal/bin
if test -d $CABAL_BIN_PATH
    fish_add_path $CABAL_BIN_PATH
end

# ccache
set CCACHE_BIN_PATH /usr/lib/ccache
if test -d $CCACHE_BIN_PATH
    fish_add_path $CCACHE_BIN_PATH
end

# cargo
set CARGO_BIN_DIR {$HOME}/.cargo/bin
if test -d "$CARGO_BIN_DIR"
   fish_add_path "$CARGO_BIN_DIR"
end

# mise
set MISE_SHIMS_DIR {$HOME}/.local/share/mise/shims
if test -d "$MISE_SHIMS_DIR"
    fish_add_path $MISE_SHIMS_DIR (mise bin-paths)
end

# direnv
which direnv &>/dev/null
if test $status = 0
    direnv hook fish | source
end

#####################################
# Add local scripts and bin to PATH #
#####################################
fish_add_path {$HOME}/scripts {$HOME}/bin


###################
# ssh-agent Setup #
###################
set -x SSH_AUTH_SOCK {$HOME}/.ssh/ssh-agent-socket
if status --is-interactive
    # Start, if necessary, ssh-agent
    # Copied from https://gist.github.com/daniel-perry/3251940
    ssh-add -l 2> /dev/null > "$TEMP_FILE"
    set SSH_ADD_STATUS $status
    set SSH_AGENT_NUM_KEYS (cat "$TEMP_FILE" | wc -l)
    if test \( {$SSH_ADD_STATUS} != 0 \) -o \( {$SSH_AGENT_NUM_KEYS} = 0 \)
    	# kill ssh-agent and start from a clean slate
	    killall ssh-agent 2> /dev/null
	    rm -f {$SSH_AUTH_SOCK}
	    ssh-agent -a {$SSH_AUTH_SOCK} -c | \
	              sed 's/^setenv/set -x/' > "$TEMP_FILE"
	    . "$TEMP_FILE"
	    echo $SSH_AGENT_PID > $HOME/.ssh/ssh-agent.pid
	    ssh-add
    end
end

###############################
# Other environment variables #
###############################
set -x EDITOR editor

##########################################
# Program-specific Environment Variables #
##########################################
set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/ripgrep.rc

####################
# Remove temp file #
####################
rm "$TEMP_FILE"

##############
# Load Theme #
##############
. $HOME/.config/fish/modus-vivendi-24bit.fish

###########
# Cleanup #
###########
dedupe_envvars PATH TERMINFO_DIRS

#####################
# Load local config #
#####################
set LOCAL_CONFIG_PATH "$HOME/.config/fish/config.local.fish"
if test -e "$LOCAL_CONFIG_PATH"
   source "$LOCAL_CONFIG_PATH"
end
