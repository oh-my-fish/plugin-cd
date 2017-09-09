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

function cd -d "plugin-cd" -a fancy_path
  # private:
  function __empty_cd -S
    builtin cd
    set -l output_status $status

    __update_pwd

    return $output_status
  end

  function __hyphen_cd -S
    builtin cd $OLDPWD
    set -l output_status $status

    __update_pwd

    return $output_status
  end

  function __fancy_cd -S
    set -l normal_path (echo $fancy_path | sed -e 's@^\.$@:@;s@^\.\([^\.]\)@:\1@g;s@\([^\.]\)\.$@\1:@g' -e 's@\([^\.]\)\.\([^\.]\)@\1:\2@g' -e 's@\([^\.]\)\.\([^\.]\)@\1:\2@g' -e 's@\.\{2\}\(\.*\)@::\1@g' -e 's@\.@\/\.\.@g' -e 's@:@\.@g')

    builtin cd $normal_path
    set -l output_status $status

    __update_pwd
    
    return $output_status
  end

  function __update_dirstack -S
    if contains $old_pwd $dirstack
      # If the from directory is existed in stack, remove it
      set -e dirstack[(contains -i $old_pwd $dirstack)]
    end
    # Add the from directory to the head of stack
    set -g dirstack $old_pwd $dirstack

    if contains (command pwd) $dirstack
      # If the to directory is existed in stack, remove it
      set -e dirstack[(contains -i (command pwd) $dirstack)]
    end
  end
  
  function __update_pwd -S
    if test $old_pwd != (command pwd)
      set -xg OLDPWD $old_pwd
      __update_dirstack
    end
  end

  # body:
  set -l old_pwd (pwd)

  switch "$fancy_path"
    case ''
      __empty_cd
    case '-'
      __hyphen_cd
    case '*'
      __fancy_cd
      return 1
  end
end
