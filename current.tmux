#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${CURRENT_DIR}/scripts/alias
tmux set-hook -g after-set-option           '%if "#{==:#{@NvimStart},true}" display -p "NVIM"'
tmux set-hook -g session-created            'source-file "${TMUX_ROOT}/tmux.conf"'
tmux set-hook -g session-window-changed[0]  'source-file "${TMUX_ROOT}/tmux.conf"'
tmux set-hook -g after-new-window[0]        'source-file "${TMUX_ROOT}/tmux.conf"'
tmux set-hook -g pane_mode_changed[0]       'source-file "${TMUX_ROOT}/tmux.conf"'
tmux bind M-t run-shell "$CURRENT_DIR/scripts/current.sh 1"
tmux run-shell "$CURRENT_DIR/scripts/current.sh"
