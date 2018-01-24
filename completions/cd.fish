function __complete_omf_cd
  function __resolve_dot_path
    echo $argv |                                                   \
      sed -e 's@^\.$@:@;s@^\.\([^\.]\)@:\1@g;s@\([^\.]\)\.$@\1:@g' \
      -e 's@\([^\.]\)\.\([^\.]\)@\1:\2@g'                          \
      -e 's@\([^\.]\)\.\([^\.]\)@\1:\2@g'                          \
      -e 's@\.\{2\}\(\.*\)@::\1@g'                                 \
      -e 's@\.@\/\.\.@g'                                           \
      -e 's@:@\.@g'
  end

  function __resolve_home_path
    echo $argv |\
      sed -e "s@^~@$HOME@"
  end

  function __resolve_fancy_path
    __resolve_dot_path (__resolve_home_path $argv)
  end

  function __get_basepath
    set -l __base (echo $argv | rev | cut -d/ -s -f2- | rev)
    if string match -qr '^/' "$argv"; and test -z $__base
      echo '/'
    else
      echo $__base
    end
  end

  function __get_filename
    echo $argv | rev | cut -d/ -f1 | rev
  end

  function __filter_directory
    while read -l __name
      if test -d "$argv/$__name"
        echo "$__name/"
      end
    end
  end
  
  function __list_and_filter
    if test -d $argv[1]
      command ls -a $argv[1] | __filter_directory $argv[1] | grep -e (echo $argv[2] | sed -e 's@\.@\\\.@g' -e 's@^@\^@')
    end
  end

  function __list_all
    
    set -l __basepath (__get_basepath $argv)
    set -l __filename (__get_filename $argv)

    if test -n "$__basepath"
      set __candidate (__list_and_filter $__basepath $__filename)
    else
      set __candidate (__list_and_filter . $__filename)
    end

    if test -n "$CDPATH"; and test -d "$CDPATH"
      echo "$CDPATH~~~~~~~~~" >> /tmp/cd.log
      set __candidate $__candidate (__list_and_filter "$CDPATH/$__basepath" $__filename)
    end

    for __c in $__candidate
      if test "$__c" = './'; or test "$__c" = '../'
      else if test -z "$__c"
      else
        echo $__c
      end
    end
  end

  set -l token $argv

  if test "$token" = "~"
    echo "~/"
    return 0
  end
  
  set -l basepath (__get_basepath $token)
  set -l resolved_path (__resolve_fancy_path $token)
  
  if test -d $resolved_path; and string match -qr '[^/]$' $resolved_path
    echo "$token/"
  end
  
  if test -z "$basepath"
    __list_all $resolved_path | sort -u
  else if test "$basepath" = '/'
    __list_all $resolved_path | sed "s@^@/@" | sort -u
  else
    __list_all $resolved_path | sed "s@^@$basepath/@" | sort -u
  end
end

function __fish_complete_plugin_cd -d "Completions for the plugin-cd command"
  # Start
	set -l token (commandline -ct)
  __complete_omf_cd $token
end

complete -c cd -e
complete -f -c cd -a "(__fish_complete_plugin_cd)"
