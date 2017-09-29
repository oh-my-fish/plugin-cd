function __fish_complete_plugin_cd -d "Completions for the plugin-cd command"
	set -l token (commandline -ct)
  set -l last_two_char (echo $token | sed 's/.*\(..\)/\1/')
  if test "$last_two_char" = ".."
    echo "$token/"
  else
    set -l base (echo $token | rev | cut -d/ -s -f2- | rev )
    test -n $base; and set -l base $base/
    set -l resolved_path (echo $token | sed -e 's@^\.$@:@;s@^\.\([^\.]\)@:\1@g;s@\([^\.]\)\.$@\1:@g' -e 's@\([^\.]\)\.\([^\.]\)@\1:\2@g' -e 's@\([^\.]\)\.\([^\.]\)@\1:\2@g' -e 's@\.\{2\}\(\.*\)@::\1@g' -e 's@\.@\/\.\.@g' -e 's@:@\.@g')
    
    if test -e $resolved_path; and not test -d $resolved_path
      return
    else
      printf "%s\n" (command ls -adp "$resolved_path"* | sed 's|.*/\([^/]*.\)$|\1|' | sed "s|^|$base|")
    end
  end
end

complete -c cd -e
complete -f -c cd -a "(__fish_complete_plugin_cd)"
