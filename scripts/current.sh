#! /usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
debug=$1
[[ ! debug ]] && debug=0
SPID=
CPID=
ICOND=$CURRENT_DIR/../lib
ICON=
main () {
  PANEPID=$( tmux display -p "#{pane_pid}" )
  CHILDPID=$(pgrep -P "${PANEPID}")
  FILEN=$(ps --no-headers -o command -p "${CHILDPID}" )
  PINFO=$( tmux list-panes -F "#{pane_current_command}:#{pane_pid}" | grep -e "$SPID" )
  setStatusBar
  [[ debug -ne 0 ]] && dbug
}

setStatusBar () {
  local currentData=
  local name=
  local file=
  local icon=
  if [[ ! $CHILDPID ]]; then 
    name="${PINFO%%:*}"
    icon="$(grep -e "$name" $ICOND/app-icons.yml)"
    ICON="${icon##*:}"
    currentData="${name}"
  else
    name="${FILEN%% *}"
    file="${FILEN##* }"
    local icon=$( tmux display -p "#{@Document}" )
    currentData="${icon} ${file}"
  fi
  tmux set -g @CurrentData "${currentData}"
  tmux set -g @Current "#[fg=#{@Dark2},bg=#{@Dark0}]#{@TriangleL}#[fg=#{@Light2},bg=#{@Dark2}] #{@CurrentData} #[fg=#{@Dark2},bg=#{@Dark0}]#{@TriangleRInverse}"
  tmux set -g status-right "#{E:@Current}#{T:@DateTime}"
  tmux set -g status-right-length 0
}

dbug () {
  echo "Running in active pane: ${PINFO%%:*} PID: ${PINFO##*:}"
  printf "PANEPID: %s\nCHILDPID: %s\nFILEN: %s\nICOND: %s\nICON: %s\n" "${PANEPID}" "${CHILDPID}" "${FILEN}" "${ICOND}" "${ICON}"
}
main
