#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#tmux set-hook -g session-window-changed[1] run-shell "$CURRENT_DIR/scripts/current.sh"
tmux set-hook -g session-window-changed[0] source-file "${CURRENT_DIR}/tmux.conf"
tmux set-hook -g session-window-changed[0] display -p "${hook}"

tmux bind M-t run-shell "$CURRENT_DIR/scripts/current.sh"
tmux run-shell "$CURRENT_DIR/scripts/current.sh"
