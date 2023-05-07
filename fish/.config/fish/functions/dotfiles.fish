function dotfiles
  if test (count $argv) -ne 1
    echo "incorrect usage!"
    echo "dotfiles [load | remove | switch]"
    exit 1
  end

  set current_dir (pwd)
  cd $DOTFILES

  switch $argv[1]
    case "load"
      git fetch
      git pull
      for package in */
        stow --dir=$DOTFILES --target=$HOME --verbose --restow $package
      end

    case "remove"
      for package in */
        stow --dir=$DOTFILES --target=$HOME --verbose --delete $package
      end

    case "switch"
      set current_branch (git symbolic-ref --short HEAD)
      if test $current_branch = "mainline"
        yes | fish_config theme save "latte"
        git checkout light_mode
      else
        yes | fish_config theme save "frappe"
        git checkout mainline
      end

    case "*"
      echo "Command not supported ($argv)"
  end

  cd $current_dir
end
