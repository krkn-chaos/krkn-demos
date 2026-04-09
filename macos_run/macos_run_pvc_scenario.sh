#!/bin/bash
source ./env.sh

$PODMAN rm --ignore pvc-"$($YQ ".scenarios.pvc-scenario.pvc-name" $CONFIG)"-scenario

$PODMAN run --name=pvc-"$($YQ ".scenarios.pvc-scenario.pvc-name" $CONFIG)"-scenario \
  --net=host \
  --env PVC_NAME="$($YQ ".scenarios.pvc-scenario.pvc-name" $CONFIG)" \
  --env POD_NAME="$($YQ ".scenarios.pvc-scenario.pod-name" $CONFIG)" \
  --env NAMESPACE="$($YQ ".scenarios.pvc-scenario.namespace" $CONFIG)" \
  --env FILL_PERCENTAGE="$($YQ ".scenarios.pvc-scenario.fill-percentage" $CONFIG)" \
  --env DURATION="$($YQ ".scenarios.pvc-scenario.duration" $CONFIG)" \
  --env WAIT_DURATION="$WAIT_DURATION" \
  -v $KUBECONFIG:/home/krkn/.kube/config:Z \
  quay.io/krkn-chaos/krkn-hub:pvc-scenarios
