#!/usr/bin/env bash



# need to rewrite this to remove the Users/wexokk/Projects from the fzf and append after select.

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find ~/Projects -mindepth 1 -maxdepth 1 -type d | \
    echo -e "$(cat -)\n/Users/wexokk" | \
    echo -e "$(cat -)\n/Users/wexokk/.dotfiles" | \
    echo -e "$(cat -)\n/Users/wexokk/Projects/daarbakgroup/backend/backend"  \
    | fzf)
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ "$selected_name" == "wexokk" ]]; then
  selected_name="HOME"
elif [[ "$selected_name" == "_dotfiles" ]]; then
  selected-name="DOTFILES"
  echo "$selected_name"
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
