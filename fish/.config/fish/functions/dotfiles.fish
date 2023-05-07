function dotfiles
  if test (count $argv) -eq 0
    echo "incorrect usage!"
    echo "dotfiles [load | remove] [light]"
    exit 1
  end

  set current_dir (pwd)
  cd $DOTFILES

  switch $argv[2]
    case "light"
      yes | fish_config theme save "latte"
      git checkout light_mode
    case "*"
      yes | fish_config theme save "frappe"
      git checkout mainline
  end

  git fetch
  git pull

  switch $argv[1]
    case "load"
      for package in */
        stow --dir=$DOTFILES --target=$HOME --verbose --restow $package
      end
    case "remove"
      for package in */
        stow --dir=$DOTFILES --target=$HOME --verbose --delete $package
      end
    case "*"
      echo "Command not supported ($argv)"
  end

  cd $current_dir
end
