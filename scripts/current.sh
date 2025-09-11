#!/usr/bin/env bash
SPID=
CPID=
main () {
  printf "%s is running\n" "${0##*/}"
  SPID=$( tmux display -p "#{pane_pid}" )
  CPID=$( ps --no-headers --ppid $( tmux display -p "#{pane_pid}" ) -o comm,pid )
  PANEID=$( tmux display -p "#{pane_id}" )
  #tmux list-panes -F "#{pane_id}:#{pane-current-command}"
  tmux list-panes -F "#P #{pane_id} #{pane_current_command} #{pane_pid}" | grep -e "$SPID"
  setStatusBar
  dbug
}

setStatusBar () {
  tmux set -g @CurrentData "#W"
  tmux set -g @Current-style "fg=#{@Dark2},bg=#{@Dark}"
  tmux set -g @Current "#[fg=#{@Dark2},bg=#{@Dark0}]#{@TriangleL}#[fg=#{@Light2},bg=#{@Dark2}] #W #[fg=#{@Dark2},bg=#{@Dark0}]#{@TriangleRInverse}"
  tmux set -g status-right "#{E:@Current}#{T:@DateTime}"
  tmux set -g status-right-length 0
}

dbug () {
  echo "Shell PID: $SPID"
  echo "Child PID: $CPID"
}
main
