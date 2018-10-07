functions -e cd

if functions -q __wrapped_cd
  functions -c __wrapped_cd cd
  functions -e __wrapped_cd
end
