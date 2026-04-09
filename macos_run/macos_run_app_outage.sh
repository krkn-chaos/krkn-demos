#!/bin/bash

source ./env.sh

$PODMAN rm --ignore "$($YQ ".scenarios.app-outage.namespace" $CONFIG)"-application_outage

$PODMAN run --name="$($YQ ".scenarios.app-outage.namespace" $CONFIG)"-application_outage \
  --net=host \
  --env DURATION="$($YQ ".scenarios.app-outage.duration" $CONFIG)" \
  --env NAMESPACE="$($YQ ".scenarios.app-outage.namespace" $CONFIG)" \
  --env BLOCK_TRAFFIC_TYPE="$($YQ ".scenarios.app-outage.block-traffic" $CONFIG)" \
  --env POD_SELECTOR="$($YQ ".scenarios.app-outage.pod-selector" $CONFIG)" \
  --env WAIT_DURATION="$WAIT_DURATION" \
  -v $KUBECONFIG:/home/krkn/.kube/config:Z \
  quay.io/krkn-chaos/krkn-hub:application-outages
