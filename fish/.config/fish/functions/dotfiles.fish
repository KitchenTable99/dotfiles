function dotfiles
  set current_dir (pwd)
  cd $DOTFILES

  switch $argv
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
