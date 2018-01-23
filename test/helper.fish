set -l fish_tank /usr/local/share/fish-tank/tank.fish
if not test -e $fish_tank
  echo 'Install fish-tank for running the tests (https://github.com/terlar/fish-tank)'
  git clone --depth 1 https://github.com/terlar/fish-tank.git /tmp/fish-tank
  cd /tmp/fish-tank/
  make install
end

source $fish_tank

set -U tank_reporter spec


