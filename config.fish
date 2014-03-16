# Temp file for configuration
set TEMP_FILE (mktemp)

# Add system directories to PATH
set -x PATH {$PATH} /bin /usr/bin /usr/local/bin /sbin /usr/sbin /usr/local/sbin

# Add toast to environment if it exists
if test -x "$HOME/.toast/armed/bin/toast"
   ~/.toast/armed/bin/toast env | \
       sed -r 's/;.*$//;s/^([^=]+)=/set -x \1 /;s/:/ /g' > \
       "$TEMP_FILE"
   . "$TEMP_FILE"
end

# Add cabal to environment
set -x PATH {$HOME}/.cabal/bin {$PATH}

# Add rubygems to environment
set -x PATH {$HOME}/.gem/ruby/2.0.0/bin {$PATH}

# Add ccache to PATH
set -x PATH /usr/lib/ccache {$PATH}

# Add local scripts and bin to PATH
set -x PATH {$HOME}/scripts {$HOME}/bin {$PATH}

if status --is-interactive
    # Start, if necessary, ssh-agent
    # Stolen from https://gist.github.com/daniel-perry/3251940
    set -x SSH_AUTH_SOCK {$HOME}/.ssh/ssh-agent-socket
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

    # Set EDITOR to editor
    set -x EDITOR editor
end

# Deduplicate PATH
set -x PATH (echo $PATH | tr ' ' '\n' | perl -ne 'BEGIN { %seen = (); } chomp $_; if (!defined($seen{$_})) { print $_ . "\n"; $seen{$_} = 1; }')

# Remove temp file
rm "$TEMP_FILE"
