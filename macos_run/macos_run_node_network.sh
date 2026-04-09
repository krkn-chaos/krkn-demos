#!/bin/bash

source ./env.sh

INGRESS="$($YQ ".scenarios.node-network-filter.ingress" $CONFIG)"
TRAFFIC_TYPE="$( [ "$INGRESS" = "true" ] && echo ingress || echo egress )"

$PODMAN rm --ignore node-network-filter

$PODMAN run --name=node-network-filter --net=host \
  --env DURATION="$($YQ ".scenarios.node-network-filter.duration" $CONFIG)" \
  --env NODE_NAME="$($YQ ".scenarios.node-network-filter.node-name" $CONFIG)" \
  --env LABEL_SELECTOR="$($YQ ".scenarios.node-network-filter.node-selector" $CONFIG)" \
  --env INSTANCE_COUNT="$($YQ ".scenarios.node-network-filter.instance-count" $CONFIG)" \
  --env EXECUTION="$($YQ ".scenarios.node-network-filter.execution" $CONFIG)" \
  --env INTERFACES="$($YQ ".scenarios.node-network-filter.interfaces" $CONFIG)" \
  --env TRAFFIC_TYPE="$TRAFFIC_TYPE" \
  --env WAIT_DURATION="$WAIT_DURATION" \
  -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:node-network-filter
