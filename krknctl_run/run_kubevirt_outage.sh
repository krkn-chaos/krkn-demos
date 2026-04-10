#!/bin/bash

source ./env.sh
[ -z "$(which krknctl)" ] && echo "krknctl not found or not installed" && exit 1

NAMESPACE="$($YQ ".scenarios.kubevirt-outage.namespace" $CONFIG)"
VM_NAME="$($YQ ".scenarios.kubevirt-outage.vm-name" $CONFIG)"
TIMEOUT="$($YQ ".scenarios.kubevirt-outage.timeout" $CONFIG)"
KILL_COUNT="$($YQ ".scenarios.kubevirt-outage.kill-count" $CONFIG)"

# Virt checks
VIRT_NAMESPACE="$($YQ ".scenarios.kubevirt-outage.virt-checks.namespace" $CONFIG)"
VIRT_NAME="$($YQ ".scenarios.kubevirt-outage.virt-checks.name" $CONFIG)"
VIRT_INTERVAL="$($YQ ".scenarios.kubevirt-outage.virt-checks.interval" $CONFIG)"
VIRT_ONLY_FAILURES="$($YQ ".scenarios.kubevirt-outage.virt-checks.only-failures" $CONFIG)"
VIRT_DISCONNECTED="$($YQ ".scenarios.kubevirt-outage.virt-checks.disconnected" $CONFIG)"
VIRT_SSH_NODE="$($YQ ".scenarios.kubevirt-outage.virt-checks.ssh-node" $CONFIG)"
VIRT_EXIT_ON_FAILURE="$($YQ ".scenarios.kubevirt-outage.virt-checks.exit-on-failure" $CONFIG)"

set -x
krknctl run kubevirt-outage \
  --namespace "$NAMESPACE" \
  --vm-name "$VM_NAME" \
  --timeout "$TIMEOUT" \
  --kill-count "$KILL_COUNT" \
  --kubevirt-namespace "$VIRT_NAMESPACE" \
  --kubevirt-name "$VIRT_NAME" \
  --kubevirt-check-interval "$VIRT_INTERVAL" \
  --kubevirt-only-failures "$VIRT_ONLY_FAILURES" \
  --kubevirt-disconnected "$VIRT_DISCONNECTED" \
  --kubevirt-ssh-node "$VIRT_SSH_NODE" \
  --kubevirt-exit-on-failure "$VIRT_EXIT_ON_FAILURE" \
  --wait-duration "$WAIT_DURATION"
set +x
