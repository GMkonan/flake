#!/usr/bin/env bash

export PATH="$PATH@tmux@"

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/code/projects ~/code/work -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -ds "flake" -c "$HOME/flake" -e "CMD=$EDITOR ."
    tmux new-window -dt "flake:2" -c "$HOME/flake" -e "CMD="

    tmux new-session -ds "dotfiles" -c "$HOME/dotfiles" -e "CMD=$EDITOR ."
    tmux new-window -dt "dotfiles:2" -c "$HOME/dotfiles" -e "CMD="

    tmux new-session -ds "$selected_name" -c "$selected" -e "CMD=$EDITOR ."
    tmux new-window -dt "$selected_name:2" -c "$selected" -e "CMD="

    tmux attach-session -t $selected_name:1
    exit 0
fi

current_session=$(tmux display-message -p "#S")

if ! tmux has-session "-t=$selected_name" 2> /dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected" -e "CMD=$EDITOR ."
    tmux new-window -dt "$selected_name:2" -c "$selected" -e "CMD="
fi

tmux switch-client -t "$selected_name"

if [[ "$current_session" == \#* ]]; then
    tmux kill-session -t "$current_session"
fi
