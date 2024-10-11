#!/bin/bash
source ./env.sh

$PODMAN rm --ignore pvc-"$($YQ ".scenarios.pvc-scenario.pvc-name" $CONFIG)"-scenario

$PODMAN run --name=pvc-"$($YQ ".scenarios.pvc-scenario.pvc-name" $CONFIG)"-scenario --net=host -e PVC_NAME="$($YQ ".scenarios.pvc-scenario.pvc-name" $CONFIG)" -e POD_NAME="$($YQ ".scenarios.pvc-scenario.pod-name" $CONFIG)" -e NAMESPACE="$($YQ ".scenarios.pvc-scenario.namespace" $CONFIG)" -e FILL_PERCENTAGE="$($YQ ".scenarios.pvc-scenario.fill-percentage" $CONFIG)" -e DURATION="$($YQ ".scenarios.pvc-scenario.duration" $CONFIG)" -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:pvc-scenarios
