#!/bin/bash

source ./env.sh

$PODMAN rm --ignore kubevirt-outage

$PODMAN run --name=kubevirt-outage --net=host \
  --env NAMESPACE="$($YQ ".scenarios.kubevirt-outage.namespace" $CONFIG)" \
  --env VM_NAME="$($YQ ".scenarios.kubevirt-outage.vm-name" $CONFIG)" \
  --env TIMEOUT="$($YQ ".scenarios.kubevirt-outage.timeout" $CONFIG)" \
  --env KILL_COUNT="$($YQ ".scenarios.kubevirt-outage.kill-count" $CONFIG)" \
  --env KUBEVIRT_CHECK_INTERVAL="$($YQ ".scenarios.kubevirt-outage.virt-checks.interval" $CONFIG)" \
  --env KUBEVIRT_NAMESPACE="$($YQ ".scenarios.kubevirt-outage.virt-checks.namespace" $CONFIG)" \
  --env KUBEVIRT_NAME="$($YQ ".scenarios.kubevirt-outage.virt-checks.name" $CONFIG)" \
  --env KUBEVIRT_ONLY_FAILURES="$($YQ ".scenarios.kubevirt-outage.virt-checks.only-failures" $CONFIG)" \
  --env KUBEVIRT_DISCONNECTED="$($YQ ".scenarios.kubevirt-outage.virt-checks.disconnected" $CONFIG)" \
  --env KUBEVIRT_SSH_NODE="$($YQ ".scenarios.kubevirt-outage.virt-checks.ssh-node" $CONFIG)" \
  --env KUBEVIRT_EXIT_ON_FAILURE="$($YQ ".scenarios.kubevirt-outage.virt-checks.exit-on-failure" $CONFIG)" \
  --env WAIT_DURATION="$WAIT_DURATION" \
  -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:kubevirt-outage
