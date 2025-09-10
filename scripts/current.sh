#!/usr/bin/env bash
main () {
  printf "%s is running, but WHY?\n" $0
  SPID=$( tmux display -p "#{pane_pid}" )
  CPID=$( ps -C  $SPID --noheaders )
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
