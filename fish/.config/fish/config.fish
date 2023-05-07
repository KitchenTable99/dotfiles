if status is-interactive
    # Commands to run in interactive sessions can go here
end

# abbr
abbr c 'clear'
abbr n 'nvim'
abbr tn "tmux new -s (pwd | sed 's/.*\///g')"
abbr lg 'lazygit'

# initialize cli helpers
starship init fish | source
zoxide init fish | source

# set env_vars
set -gx DOTFILES /Users/cbitting/Documents/Coding/dotfiles
