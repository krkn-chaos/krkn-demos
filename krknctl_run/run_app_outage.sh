#!/bin/bash

source ./env.sh
[ -z "$(which krknctl)" ] && echo "krknctl not found or not installed" && exit 1

DURATION="$($YQ ".scenarios.app-outage.duration" $CONFIG)"
NAMESPACE="$($YQ ".scenarios.app-outage.namespace" $CONFIG)"
BLOCK_TRAFFIC_TYPE="$($YQ ".scenarios.app-outage.block-traffic" $CONFIG)"
POD_SELECTOR="$($YQ ".scenarios.app-outage.pod-selector" $CONFIG)"

set -x
krknctl run application-outages \
  --chaos-duration "$DURATION" \
  --namespace "$NAMESPACE" \
  --block-traffic-type "$BLOCK_TRAFFIC_TYPE" \
  --pod-selector "$POD_SELECTOR" \
  --wait-duration "$WAIT_DURATION"
set +x
