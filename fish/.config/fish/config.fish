if status is-interactive
    # Commands to run in interactive sessions can go here
end

# initialize cli helpers
starship init fish | source
zoxide init fish | source

# set env_vars
set -gx DOTFILES /Users/cbitting/Documents/Coding/dotfiles

# abbr
abbr c 'clear'
abbr n 'nvim'
abbr tn "tmux new -s (pwd | sed 's/.*\///g')"

# git 
abbr lg 'lazygit'
abbr gp 'git push'
abbr gl 'git pull'
abbr gst 'git status'
abbr gcam 'git commit -a -m'
abbr gcdc 'git commit --allow-empty -m "dummy commit"'
