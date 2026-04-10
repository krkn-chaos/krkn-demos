#!/bin/bash

source ./env.sh

export DURATION="$($YQ ".scenarios.node-network-filter.duration" $CONFIG)"
export NODE_NAME="$($YQ ".scenarios.node-network-filter.node-name" $CONFIG)"
export LABEL_SELECTOR="$($YQ ".scenarios.node-network-filter.node-selector" $CONFIG)"
export INSTANCE_COUNT="$($YQ ".scenarios.node-network-filter.instance-count" $CONFIG)"
export EXECUTION="$($YQ ".scenarios.node-network-filter.execution" $CONFIG)"
export INTERFACES="$($YQ ".scenarios.node-network-filter.interfaces" $CONFIG)"
export TRAFFIC_TYPE="$( [ "$($YQ ".scenarios.node-network-filter.ingress" $CONFIG)" = "true" ] && echo ingress || echo egress )"

$PODMAN rm --ignore node-network-filter
$PODMAN run --name=node-network-filter --net=host --env-host=true -e WAIT_DURATION="$WAIT_DURATION" -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:node-network-filter
