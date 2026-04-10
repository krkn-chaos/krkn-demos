#!/bin/bash

source ./env.sh
[ -z "$(which krknctl)" ] && echo "krknctl not found or not installed" && exit 1

PVC_NAME="$($YQ ".scenarios.pvc-scenario.pvc-name" $CONFIG)"
POD_NAME="$($YQ ".scenarios.pvc-scenario.pod-name" $CONFIG)"
NAMESPACE="$($YQ ".scenarios.pvc-scenario.namespace" $CONFIG)"
FILL_PERCENTAGE="$($YQ ".scenarios.pvc-scenario.fill-percentage" $CONFIG)"
DURATION="$($YQ ".scenarios.pvc-scenario.duration" $CONFIG)"

set -x
krknctl run pvc-scenarios \
  --pvc-name "$PVC_NAME" \
  --pod-name "$POD_NAME" \
  --namespace "$NAMESPACE" \
  --fill-percentage "$FILL_PERCENTAGE" \
  --duration "$DURATION" \
  --wait-duration "$WAIT_DURATION"
set +x
