# SYNOPSIS
#   cd [DIRECTORY|DOTS]
#
# Description
#   cd changes the current working directory. It's a proxy directive of the buildin
#   cd command with an alias of going to the upper directory.
#
# Examples
#   cd .../foo <=> cd ../../foo
#   cd ... <=> cd ../..
#   cd .../foo/.../bar <=> cd ../../foo/../../bar

function cd -d "plugin-cd" -a directory
  if test -n "$directory"
      set -l directory (echo $directory | sed -e 's@^.$@:@;s@^\.\([^\.]\)@:\1@g;s@\([^\.]\)\.$@\1:@g' -e 's@\([^\.]\)\.\([^\.]\)@\1:\2@g' -e 's@\.\{2\}\(\.*\)@::\1@g' -e 's@\.@\/\.\.@g' -e 's@:@\.@g')
      builtin cd $directory
    else
      builtin cd
    end
end
