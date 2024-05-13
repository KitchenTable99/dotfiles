function tt
    if test (count $argv) -eq 0
        echo "No URL provided (or too many)"
        return 1
    end

    # get ticket out of url
    set url (string escape -- $argv[1])
    set splits (string split "/" $url)
    for split in $splits
        if string match -qr "^[VP]\d+\$" $split
            set ticket_num $split
            break
        end
    end

    if not set -q ticket_num
        echo "Couldn't find ticket num in $url"
        return 1
    end

    # create a session if it doesn't exist
    if not tmux has-session -t $ticket_num 2>/dev/null
        tmux new-session -d -s $ticket_num -c $HOME
        tmux new-window -t $ticket_num -c $HOME
        tmux send-keys -t $ticket_num:2 "ssh clouddesk" C-m
        tmux select-window -t $ticket_num:1
    end

    if set -q TMUX
        # we are already in a TMUX session
        tmux switch-client -t $ticket_num
    else
        tmux attach-session -t $ticket_num
    end
end
