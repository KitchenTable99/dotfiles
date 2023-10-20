if status is-interactive
    # Commands to run in interactive sessions can go here
end

# initialize cli helpers
starship init fish | source
zoxide init fish | source
mcfly init fish | source

# set env_vars
set -gx DOTFILES /Users/ccbitt/Documents/03\ Resources/dotfiles

# abbr
abbr c 'clear'
abbr n 'nvim'
abbr tn "tmux new -s (pwd | sed 's/.*\///g')"
abbr creds 'mwinit && kinit'
abbr i 'isengardcli'

# brazil
abbr -a bb brazil-build
abbr -a bre brazil-runtime-exec
abbr -a brc brazil-recursive-cmd
abbr -a bws brazil workspace
abbr -a bwsuse brazil workspace use --gitMode -p
abbr -a bbr brazil-recursive-cmd brazil-build
abbr -a bba brazil-build apollo-pkg
abbr -a bte brazil-test-exec

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
