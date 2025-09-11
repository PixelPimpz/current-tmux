#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux set-hook -g after-new-window[0] source-file "$CURRENT_DIR/current.tmux"
tmux set-hook -g after-select-pane[0] source-file "$CURRENT_DIR/current.tmux"
tmux set-hook -g window-pane-changed[0] source-file "$CURRENT_DIR/current.tmux"
tmux set-hook -g pane-focus-in[0] source-file "$CURRENT_DIR/current.tmux"
tmux set-hook -g pane-focus-out[0] source-file "$CURRENT_DIR/current.tmux"

tmux bind M-t run-shell "$CURRENT_DIR/scripts/current.sh"
tmux run-shell "$CURRENT_DIR/scripts/current.sh"
