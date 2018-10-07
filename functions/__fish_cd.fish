function __fish_cd
  if functions -q __wrapped_cd
    __wrapped_cd $argv
  else
    builtin cd $argv
  end
end
