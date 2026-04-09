#!/bin/bash

source ./env.sh

export NAMESPACE="$($YQ ".scenarios.kubevirt-outage.namespace" $CONFIG)"
export VM_NAME="$($YQ ".scenarios.kubevirt-outage.vm-name" $CONFIG)"
export TIMEOUT="$($YQ ".scenarios.kubevirt-outage.timeout" $CONFIG)"
export KILL_COUNT="$($YQ ".scenarios.kubevirt-outage.kill-count" $CONFIG)"

# Virt checks
export KUBEVIRT_CHECK_INTERVAL="$($YQ ".scenarios.kubevirt-outage.virt-checks.interval" $CONFIG)"
export KUBEVIRT_NAMESPACE="$($YQ ".scenarios.kubevirt-outage.virt-checks.namespace" $CONFIG)"
export KUBEVIRT_NAME="$($YQ ".scenarios.kubevirt-outage.virt-checks.name" $CONFIG)"
export KUBEVIRT_ONLY_FAILURES="$($YQ ".scenarios.kubevirt-outage.virt-checks.only-failures" $CONFIG)"
export KUBEVIRT_DISCONNECTED="$($YQ ".scenarios.kubevirt-outage.virt-checks.disconnected" $CONFIG)"
export KUBEVIRT_SSH_NODE="$($YQ ".scenarios.kubevirt-outage.virt-checks.ssh-node" $CONFIG)"
export KUBEVIRT_EXIT_ON_FAILURE="$($YQ ".scenarios.kubevirt-outage.virt-checks.exit-on-failure" $CONFIG)"

$PODMAN rm --ignore kubevirt-outage
$PODMAN run --name=kubevirt-outage --net=host --env-host=true -e WAIT_DURATION="$WAIT_DURATION" -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:kubevirt-outage
