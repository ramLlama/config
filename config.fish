# Temp file for configuration
set TEMP_FILE (mktemp)

# Add toast to environment
./.toast/armed/bin/toast env | \
    sed -r 's/;.*$//;s/^([^=]+)=/set -x \1 /;s/:/ /g' > \
    "$TEMP_FILE"
. "$TEMP_FILE"

# Add cabal to environment
set -x PATH {$HOME}/.cabal/bin {$PATH}

# Add scripts to PATH
set -x PATH {$HOME}/scripts {$PATH}

if status --is-interactive
    # Start, if necessary, ssh-agent
    # Stolen from https://gist.github.com/daniel-perry/3251940
    set -x SSH_AUTH_SOCK {$HOME}/.ssh/ssh-agent-socket
    set NKEYS_SSHAGENT (ssh-add -l 2> /dev/null | wc -l)
    if test {$NKEYS_SSHAGENT} = 0
	# No ssh-agent running
	rm -f {$SSH_AUTH_SOCK}
	ssh-agent -a {$SSH_AUTH_SOCK} -c | \
	    sed 's/^setenv/set -x/' | \
	    sed 's/^echo/#echo/' > /tmp/.ssh-script
	. /tmp/.ssh-script
	echo $SSH_AGENT_PID > $HOME/.ssh/ssh-agent.pid
	rm -f /tmp/.ssh-script
	ssh-add {$HOME}/.ssh/id_rsa
    end

    # Set EDITOR to editor
    set -x EDITOR editor
end

# Remove temp file
rm "$TEMP_FILE"
