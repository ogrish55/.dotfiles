#!/usr/bin/env bash

declare -A folders

if [[ $# -eq 1 ]]; then
  selected=$1
else
  result=$(find ~/Projects -mindepth 1 -maxdepth 1 -type d -not -path "/Users/wexokk/Projects/daarbakgroup" | \
    echo -e "$(cat -)\n/Users/wexokk" | \
    echo -e "$(cat -)\n/Users/wexokk/.dotfiles" | \
    echo -e "$(cat -)\n/Users/wexokk/Projects/daarbakgroup/backend/daarbak-orders" | \
    echo -e "$(cat -)\n/Users/wexokk/Projects/daarbakgroup/backend/modules" | \
    echo -e "$(cat -)\n/Users/wexokk/Projects/daarbakgroup/backend/modules-composer" | \
    echo -e "$(cat -)\n/Users/wexokk/Projects/daarbakgroup/backend/patches" | \
    echo -e "$(cat -)\n/Users/wexokk/Projects/daarbakgroup/backend/roso-backend" | \
    echo -e "$(cat -)\n/Users/wexokk/Projects/daarbakgroup/backend/scanoffice-backend" | \
    echo -e "$(cat -)\n/Users/wexokk/Projects/daarbakgroup/frontend/roso-frontend" | \
    echo -e "$(cat -)\n/Users/wexokk/Projects/daarbakgroup/middleware" | \
    echo -e "$(cat -)\n/Users/wexokk/Projects/daarbakgroup/strapi" | \
    echo -e "$(cat -)\n/Users/wexokk/Projects/personal/minmadbog" \
    )
fi

while IFS= read -r line; do
  key=$(basename "$line")
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
