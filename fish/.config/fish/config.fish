# Temp file for configuration
set TEMP_FILE (mktemp)

##################################
# Add system directories to PATH #
##################################
set -x PATH {$PATH} /bin /usr/bin /usr/local/bin /sbin /usr/sbin /usr/local/sbin

###############
# MacOS setup #
###############
# Use homebrew as test of "am I on MacOS?"
set HOMEBREW_BIN_DIR /opt/homebrew/bin
if test -d $HOMEBREW_BIN_DIR
    set -x PATH $HOMEBREW_BIN_DIR {$PATH}
    brew shellenv fish | source

    # Add LLVM paths if installed
    if test -d $HOMEBREW_PREFIX/opt/llvm
        set -x PATH $HOMEBREW_PREFIX/opt/llvm/bin {$PATH}
        set -x CPATH $HOMEBREW_PREFIX/opt/llvm/include {$CPATH}
        set -x LIBRARY_PATH \
            $HOMEBREW_PREFIX/opt/llvm/lib \
            $HOMEBREW_PREFIX/opt/llvm/lib/c++ \
            {$LIBRARY_PATH}
        set -x LDFLAGS "-Wl,-rpath,$HOMEBREW_PREFIX/opt/llvm/lib/c++"
    end

    # we're in homebrew, add relevant gnubin directories
    for GNU_BIN_DIR in \
        $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin \
        $HOMEBREW_PREFIX/opt/make/libexec/gnubin
        if test -d $GNU_BIN_DIR
            set -x PATH $GNU_BIN_DIR {$PATH}
        end
    end

    # Prefix standard header and library paths
    set -x CPATH $HOMEBREW_PREFIX/include {$CPATH}
    set -x LIBRARY_PATH $HOMEBREW_PREFIX/lib {$LIBRARY_PATH}

    # terminfo
    set -x TERMINFO_DIRS {$TERMINFO_DIRS} $HOME/.local/share/terminfo
end

#########################################
# Add toast to environment if it exists #
#########################################
if test -x $HOME/.toast/armed/bin/toast
    ~/.toast/armed/bin/toast env fish > "$TEMP_FILE"
    . "$TEMP_FILE"
end

#####################################
# Add local scripts and bin to PATH #
#####################################
set -x PATH {$HOME}/scripts {$HOME}/bin {$PATH}

############################################
# Add various ecosystem-specific bin paths #
############################################
# perl
set PERL_BIN_PATH /usr/bin/core_perl
if test -d $PERL_BIN_PATH
    set -x PATH $PERL_BIN_PATH {$PATH}
end
perl -Mlocal::lib &>/dev/null
if test $status = 0
    eval (perl -Mlocal::lib)
end

# ruby/gem
# only need to set if gem is installed
which gem &>/dev/null
if test $status = 0
    set -x PATH (gem environment gempath | tr ':' '\n' | perl -ne "chomp \$_; if (m|^$HOME/.gem|) { print \$_ . \"\n\"; exit 0; }")/bin {$PATH}
end

# haskell/cabal
set CABAL_BIN_PATH {$HOME}/.cabal/bin
if test -d $CABAL_BIN_PATH
    set -x PATH $CABAL_BIN_PATH {$PATH}
end

# ccache
set CCACHE_BIN_PATH /usr/lib/ccache
if test -d $CCACHE_BIN_PATH
    set -x PATH $CCACHE_BIN_PATH {$PATH}
end

# nvm
if test -e $HOME/.nvm/nvm.sh
    function nvm
        bass source $HOME/.nvm/nvm.sh --no-use ';' nvm $argv
    end
end

#
# Python
#

#
# rtx
#
set RTX_SHIMS_DIR {$HOME}/.local/share/rtx/shims
if test -d "$RTX_SHIMS_DIR"
    set -x PATH $RTX_SHIMS_DIR {$PATH}
end

#
# direnv
#
which direnv &>/dev/null
if test $status = 0
    direnv hook fish | source
end

###################
# ssh-agent Setup #
###################
set -x SSH_AUTH_SOCK {$HOME}/.ssh/ssh-agent-socket
if status --is-interactive
    # Start, if necessary, ssh-agent
    # Stolen from https://gist.github.com/daniel-perry/3251940
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

####################
# Deduplicate PATH #
####################
set -x PATH (echo $PATH | tr ' ' '\n' | perl -ne 'BEGIN { %seen = (); } chomp $_; if (!defined($seen{$_})) { print $_ . "\n"; $seen{$_} = 1; }')

##########################################
# Program-specific Environment Variables #
##########################################
set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/ripgrep.rc

####################
# Remove temp file #
####################
rm "$TEMP_FILE"

##################
# Load Solarized #
##################
. $HOME/.config/fish/solarized.fish

###########
# Cleanup #
###########
dedupe_envvars PATH TERMINFO_DIRS
