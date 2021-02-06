set SOURCE_DIR (dirname (status -f))

if not functions -q __wrapped_cd
  functions -c cd __wrapped_cd
  functions -e cd
end

functions -c __plugin_cd cd

function _cd_uninstall --on-event cd_uninstall
  functions -e cd

  if functions -q __wrapped_cd
    functions -c __wrapped_cd cd
    functions -e __wrapped_cd
  end

  functions -e __plugin_cd
end
