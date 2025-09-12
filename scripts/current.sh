#!/usr/bin/env bash
debug=$1
[[ ! debug ]] && debug=0
SPID=
CPID=
main () {
  #printf "%s is running\n" "${0##*x}"
  PANEPID=$( tmux display -p "#{pane_pid}" )
  CHILDPID=$(pgrep -P "${PANEPID}")
  PINFO=$( tmux list-panes -F "#{pane_current_command}:#{pane_pid}" | grep -e "$SPID" )
  setStatusBar
  [[ debug -ne 0 ]] && dbug
}

setStatusBar () {
  tmux set -g @CurrentData "${PINFO%%:*}"
  tmux set -g @Current "#[fg=#{@Dark2},bg=#{@Dark0}]#{@TriangleL}#[fg=#{@Light2},bg=#{@Dark2}] #{@CurrentData} #[fg=#{@Dark2},bg=#{@Dark0}]#{@TriangleRInverse}"
  tmux set -g status-right "#{E:@Current}#{T:@DateTime}"
  tmux set -g status-right-length 0
}

dbug () {
  echo "Running in active pane: ${PINFO%%:*} PID: ${PINFO##*:}"
  printf "PANEPID: %s\nCHILDPID: %s\n" "${PANEPID}" "${CHILDPID}"
}
main
