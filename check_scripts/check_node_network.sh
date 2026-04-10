#!/bin/bash
source ./env.sh

NODE_SELECTOR="$($YQ ".scenarios.node-network-filter.node-selector" $CONFIG)"

$WATCH -n1 "
echo '=== Node Status ===';
$OC get nodes;
echo '';
echo '=== Non-Running Pods (all namespaces) ===';
$OC get pods -A -o wide --no-headers 2>/dev/null | grep -v ' Running ' | grep -v ' Completed ';
echo '';
"
