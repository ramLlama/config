# Temp file for configuration
set TEMP_FILE (mktemp)

##################################
# Add system directories to PATH #
##################################
set -x PATH {$PATH} /bin /usr/bin /usr/local/bin /sbin /usr/sbin /usr/local/sbin

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
# ruby/gem
# only need to set if gem is installed
which gem >/dev/null ^&1
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

###################
# ssh-agent Setup #
###################
set -x SSH_AUTH_SOCK {$HOME}/.ssh/ssh-agent-socket
if status --is-interactive
    # Start, if necessary, ssh-agent
    # Stolen from https://gist.github.com/daniel-perry/3251940
    ssh-add -l ^ /dev/null > "$TEMP_FILE"
    set SSH_ADD_STATUS $status
    set SSH_AGENT_NUM_KEYS (cat "$TEMP_FILE" | wc -l)
    if test \( {$SSH_ADD_STATUS} != 0 \) -o \( {$SSH_AGENT_NUM_KEYS} = 0 \)
	# kill ssh-agent and start from a clean slate
	killall ssh-agent ^ /dev/null
	rm -f {$SSH_AUTH_SOCK}
	ssh-agent -a {$SSH_AUTH_SOCK} -c | \
	    sed 's/^setenv/set -x/' | \
	    sed 's/^echo/#echo/' > "$TEMP_FILE"
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

####################
# Remove temp file #
####################
rm "$TEMP_FILE"

##################
# Load Solarized #
##################
. $HOME/.config/fish/solarized.fish
