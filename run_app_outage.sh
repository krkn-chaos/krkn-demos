#!/bin/bash

source ./env.sh

export DURATION="$($YQ ".scenarios.app-outage.duration" $CONFIG)"
export NAMESPACE="$($YQ ".scenarios.app-outage.namespace" $CONFIG)"
export BLOCK_TRAFFIC_TYPE="$($YQ ".scenarios.app-outage.block-traffic" $CONFIG)"
export POD_SELECTOR="$($YQ ".scenarios.app-outage.pod-selector" $CONFIG)"

$PODMAN rm --ignore application_outage
$PODMAN run --name=application_outage --net=host --env-host=true -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:application-outages
