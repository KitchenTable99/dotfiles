function tn
    set basename (basename (pwd))

    if not tmux has-session -t $basename 2>/dev/null
        tmux new-session -d -s $basename
    end

    if set -q TMUX
        # we are already in a TMUX session
        tmux switch-client -t $basename
    else
        tmux attach-session -t $basename
    end
end
