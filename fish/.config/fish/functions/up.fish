function up
  set -l count $argv[1]
  set -l path ""

  # if no argument is provided, default to 1
  if test -z "$count"
    set count 1
  end

  for i in (seq $count)
    set path $path"../"
  end

  cd $path
end
