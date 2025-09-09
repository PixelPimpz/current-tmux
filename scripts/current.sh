#!/usr/bin/env bash
main () {
  printf "%s is running, but WHY?\n" $0
  SPID=$( tmux display -p "#{pane_pid}" )
  CPID=$( pgrep -P $SPID -l )
  MPID="$( ps -q $SPID -o comm= )"
  setStatusBar
  dbug
}

setStatusBar () {
  tmux set -g @CurrentData "#W"
  tmux set -g @Current-style "fg=#{@Light},bg=#{@Dark2}"
  tmux set -g @Current "#{E:@Current-style}#{@TriangleL}#[inverse] #W #[noinverse]#[bg=#{Dark0}]#{@TriangleRInverse}"
  tmux set -g status-right "#{E:@Current}#{T:@DateTime}"
  tmux set -g status-right-length 0
}

dbug () {
  echo "Shell PID: $SPID"
  echo "Child PID: $CPID"
  echo "InUse $MPID"
}
main
