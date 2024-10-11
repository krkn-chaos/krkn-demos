#!/bin/bash

source ./env.sh

$PODMAN rm --ignore "$($YQ ".scenarios.app-outage.namespace" $CONFIG)"-application_outage

$PODMAN run --name="$($YQ ".scenarios.app-outage.namespace" $CONFIG)"-application_outage --net=host  -e DURATION="$($YQ ".scenarios.app-outage.duration" $CONFIG)" -e NAMESPACE="$($YQ ".scenarios.app-outage.namespace" $CONFIG)" -e BLOCK_TRAFFIC_TYPE="$($YQ ".scenarios.app-outage.block-traffic" $CONFIG)" -e POD_SELECTOR="$($YQ ".scenarios.app-outage.pod-selector" $CONFIG)" -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:application-outages
