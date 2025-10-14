#!/bin/bash

source ../env.sh

export DURATION="$($YQ ".scenarios.app-outage.duration" $CONFIG)"
export NAMESPACE="$($YQ ".scenarios.app-outage.namespace" $CONFIG)"
export BLOCK_TRAFFIC_TYPE="$($YQ ".scenarios.app-outage.block-traffic" $CONFIG)"
export POD_SELECTOR="$($YQ ".scenarios.app-outage.pod-selector" $CONFIG)"


$KRKNCTL run application-outages \
    --kubeconfig ../kubeconfig \
    --chaos-duration "$DURATION" \
    --namespace "$NAMESPACE" \
    --block-traffic-type "$BLOCK_TRAFFIC_TYPE" \
    --pod-selector "$POD_SELECTOR"