#!/bin/bash
source ./env.sh

$PODMAN rm --ignore "$($YQ ".scenarios.pod-network.namespace" $CONFIG)"-pod-net-disruption

$PODMAN run --name="$($YQ ".scenarios.pod-network.namespace" $CONFIG)"-pod-net-disruption --net=host --env POD_NAME="$($YQ ".scenarios.pod-network.pod-name" $CONFIG)" --env NAMESPACE="$($YQ ".scenarios.pod-network.namespace" $CONFIG)" --env LABEL_SELECTOR="$($YQ ".scenarios.pod-network.pod-label" $CONFIG)" --env INSTANCE_COUNT="$($YQ ".scenarios.pod-network.instance-count" $CONFIG)" --env TRAFFIC_TYPE="$($YQ ".scenarios.pod-network.traffic-type" $CONFIG)" --env WAIT_DURATION="$($YQ ".scenarios.pod-network.wait-duration" $CONFIG)" --env TEST_DURATION="$($YQ ".scenarios.pod-network.test-duration" $CONFIG)" --env INGRESS_PORTS="$($YQ ".scenarios.pod-network.ingress-port" $CONFIG)" --env EGRESS_PORTS="$($YQ ".scenarios.pod-network.egress-port" $CONFIG)" -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:pod-network-chaos
