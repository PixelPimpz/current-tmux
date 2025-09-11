#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux set-hook -g session-window-changed[0] 'source-file "${TMUX_ROOT}/tmux.conf"'
tmux set-hook -g after-new-window[0] 'source-file "${TMUX_ROOT}/tmux.conf"'
tmux bind M-t run-shell "$CURRENT_DIR/scripts/current.sh"
tmux run-shell "$CURRENT_DIR/scripts/current.sh"
