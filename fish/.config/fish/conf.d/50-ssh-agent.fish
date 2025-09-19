# ssh-agent Setup

set TEMP_FILE (mktemp)

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