if status is-interactive
    # Commands to run in interactive sessions can go here
end

# initialize cli helpers
starship init fish | source
zoxide init fish | source

# set env_vars
set -gx DOTFILES /Users/cbitting/Documents/03\ Resources/dotfiles

# abbr
abbr c 'clear'
abbr n 'nvim'
abbr tn "tmux new -s (pwd | sed 's/.*\///g')"

# git 
abbr lg 'lazygit'
abbr gp 'git push'
abbr gl 'git pull'
abbr gf 'git fetch'
abbr gst 'git status'
abbr gcam 'git commit -a -m'
abbr gcdc 'git commit --allow-empty -m "dummy commit"'
abbr gco 'git checkout'

function should_run_nexus
    set -l last_run_file ~/.config/fish/last_nexus_run
    set -l current_date (date "+%Y-%m-%d")

    if not test -e $last_run_file
        echo $current_date > $last_run_file
        return 0
    end

    set -l last_run_date (cat $last_run_file)

    if test $last_run_date != $current_date
        echo $current_date > $last_run_file
        return 0
    end

    return 1
end

if should_run_nexus
  nexus
end
