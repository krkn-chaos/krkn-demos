#!/bin/bash
SESSION="run_graph"

# Crea una nuova sessione tmux in background
tmux new-session -d -s "$SESSION"

# Dividi il terminale verticalmente in due pannelli (sinistra e destra)
tmux split-window -h
tmux select-pane -t 1
tmux split-window -v          # Primo split: 2 pannelli a destra
tmux select-pane -t 1
tmux split-window -v          # Secondo split: 3 pannelli a destra

tmux resize-pane -t 1 -y 33%
tmux resize-pane -t 2 -y 33%
tmux resize-pane -t 3 -y 33%


tmux send-keys -t 1 "watch -n1 curl -I -s --connect-timeout 2 -m 2 dittybopper-dittybopper.apps.tsebasti-krknctl.aws.rhperfscale.org" Enter
tmux send-keys -t 2 "watch -n1 curl -I -s --connect-timeout 2 -m 2 kibana-elastic.apps.tsebasti-krknctl.aws.rhperfscale.org" Enter
tmux send-keys -t 3 "watch -n1 oc get pods -n dittybopper" Enter

tmux select-pane -t 0

tmux attach-session -t "$SESSION"