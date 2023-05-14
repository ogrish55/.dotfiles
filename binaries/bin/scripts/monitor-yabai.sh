resolution_width=$(system_profiler SPDisplaysDataType |grep Resolution | head -n 1 | awk '{print $2}')

if [ -z "$resolution_width" ]; then
  echo "No resolution width found."
  echo "Possible bug in: /Users/wexokk/.dotfiles"
  exit 0
fi

if [ $((resolution_width)) -gt 2560 ]; then
  yabai -m config left_padding 50
  yabai -m config right_padding 50
else
  yabai -m config left_padding 0
  yabai -m config right_padding 0
fi
