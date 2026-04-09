#!/bin/bash

source ./env.sh
[ -z "$(which krknctl)" ] && echo "krknctl not found or not installed" && exit 1

DURATION="$($YQ ".scenarios.node-network-filter.duration" $CONFIG)"
NODE_NAME="$($YQ ".scenarios.node-network-filter.node-name" $CONFIG)"
NODE_SELECTOR="$($YQ ".scenarios.node-network-filter.node-selector" $CONFIG)"
NAMESPACE="$($YQ ".scenarios.node-network-filter.namespace" $CONFIG)"
INSTANCE_COUNT="$($YQ ".scenarios.node-network-filter.instance-count" $CONFIG)"
EXECUTION="$($YQ ".scenarios.node-network-filter.execution" $CONFIG)"
INGRESS="$($YQ ".scenarios.node-network-filter.ingress" $CONFIG)"
EGRESS="$($YQ ".scenarios.node-network-filter.egress" $CONFIG)"
INTERFACES="$($YQ ".scenarios.node-network-filter.interfaces" $CONFIG)"
PORTS="$($YQ ".scenarios.node-network-filter.ports" $CONFIG)"
PROTOCOLS="$($YQ ".scenarios.node-network-filter.protocols" $CONFIG)"

set -x
krknctl run node-network-filter \
  --chaos-duration "$DURATION" \
  --node-name "$NODE_NAME" \
  --node-selector "$NODE_SELECTOR" \
  --namespace "$NAMESPACE" \
  --instance-count "$INSTANCE_COUNT" \
  --execution "$EXECUTION" \
  --ingress "$INGRESS" \
  --egress "$EGRESS" \
  --interfaces "$INTERFACES" \
  --ports "$PORTS" \
  --protocols "$PROTOCOLS" \
  --wait-duration "$WAIT_DURATION"
set +x
