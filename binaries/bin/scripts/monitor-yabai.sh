resolution=$(system_profiler SPDisplaysDataType |grep Resolution | head -n 1 | awk '{print $2}')

if [ $((resolution)) -gt 2560 ]; then
  yabai -m config left_padding 50
  yabai -m config right_padding 50
else
  yabai -m config left_padding 0
  yabai -m config right_padding 0
fi
