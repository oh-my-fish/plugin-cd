set SOURCE_DIR (dirname (status -f))

if not functions -q __plugin_cd_wrapped_cd
  functions -c cd __plugin_cd_wrapped_cd
  functions -e cd
end

functions -c __plugin_cd cd
