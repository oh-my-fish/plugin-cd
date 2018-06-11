#!/usr/local/bin/fish

set SOURCE_FILE (status -f)
# For fishman symlink
while test -L $SOURCE_FILE
  set SOURCE_FILE (readlink $SOURCE_FILE)
end

set SOURCE_DIR (dirname $SOURCE_FILE)

if not functions -q __plugin_cd_wrapped_cd
  functions -c cd __plugin_cd_wrapped_cd
  functions -e cd
end

if not functions -q __plugin_cd
  source $SOURCE_DIR/functions/plugin-cd.fish
end

functions -c __plugin_cd cd
