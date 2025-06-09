#!/usr/bin/env bash

# 1. Handle command-line arguments or use fzf to select a directory
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/code/projects ~/code/work -mindepth 1 -maxdepth 1 -type d | fzf)
fi

# 2. Exit if no directory was selected
if [[ -z $selected ]]; then
    exit 0
fi

# 3. Prepare session name and check Tmux status
selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

# 4. Handle case: Tmux not running and not inside a Tmux session
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

# 5. Get current Tmux session name (if inside Tmux)
current_session=$(tmux display-message -p "#S")

# 6. Create new session/windows if the selected session doesn't exist
if ! tmux has-session "-t=$selected_name" 2> /dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected" -e "CMD=$EDITOR ."
    tmux new-window -dt "$selected_name:1" -c "$selected" -e "CMD="
fi

# 7. Switch to the selected Tmux session
tmux switch-client -t "$selected_name"

# 8. Kill the current session if it's an auto-generated one (e.g., from SSH)
if [[ "$current_session" == \#* ]]; then
    tmux kill-session -t "$current_session"
fi
