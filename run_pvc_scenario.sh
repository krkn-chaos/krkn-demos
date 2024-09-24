#!/bin/bash
source ./env.sh

export PVC_NAME="$($YQ ".scenarios.pvc-scenario.pvc-name" $CONFIG)"
export POD_NAME="$($YQ ".scenarios.pvc-scenario.pod-name" $CONFIG)"
export NAMESPACE="$($YQ ".scenarios.pvc-scenario.namespace" $CONFIG)"
export FILL_PERCENTAGE="$($YQ ".scenarios.pvc-scenario.fill-percentage" $CONFIG)"
export DURATION="$($YQ ".scenarios.pvc-scenario.duration" $CONFIG)"


$PODMAN rm --ignore  pvc-scenario
$PODMAN run --name=pvc-scenario --net=host --env-host=true -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:pvc-scenarios
