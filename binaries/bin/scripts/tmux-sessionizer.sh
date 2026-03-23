#!/usr/bin/env bash

declare -A folders

if [[ $# -eq 1 ]]; then
  selected=$1
else
  result=$({
    find ~/Projects -mindepth 1 -maxdepth 1 -type d -not -path "/Users/wexokk/Projects/daarbakgroup" -not -path "/Users/wexokk/Projects/personal" -not -path "/Users/wexokk/Projects/side-projects"
    echo "/Users/wexokk"
    echo "/Users/wexokk/.dotfiles"
    find ~/Projects/personal -mindepth 1 -maxdepth 1 -type d 2>/dev/null
    find ~/Projects/side-projects -mindepth 1 -maxdepth 1 -type d 2>/dev/null
    find ~/Projects/daarbakgroup/backend -mindepth 1 -maxdepth 1 -type d 2>/dev/null
    find ~/Projects/daarbakgroup/frontend -mindepth 1 -maxdepth 1 -type d 2>/dev/null
    find ~/Projects/daarbakgroup -mindepth 1 -maxdepth 1 -type d -not -path "*/backend" -not -path "*/frontend" 2>/dev/null
  })
fi

while IFS= read -r line; do
  if [[ "$line" =~ /Projects/personal/ ]]; then
    key="personal - $(basename "$line")"
  elif [[ "$line" =~ /Projects/side-projects/ ]]; then
    key="side-projects - $(basename "$line")"
  else
    key=$(basename "$line")
  fi
  folders["$key"]="$line"
done <<< $result

keys=$(printf "%s\n" "${!folders[@]}")
selectedFolder=$(echo "$keys" | fzf)

if [[ -z $selectedFolder ]]; then
  exit 0
fi

selected=${folders[$selectedFolder]}

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ "$selected_name" == "wexokk" ]]; then
  selected_name="HOME"
elif [[ "$selected_name" == "_dotfiles" ]]; then
  selected_name="DOTFILES"
fi

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s $selected_name -c $selected
  exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null && [ -z "$TMUX" ]; then
  tmux new-session -s $selected_name -c $selected
  exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
  tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
