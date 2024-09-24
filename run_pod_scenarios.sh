#!/bin/bash
source ./env.sh

export NAMESPACE="$($YQ ".scenarios.pod-scenario.namespace" $CONFIG)"
export POD_LABEL="$($YQ ".scenarios.pod-scenario.pod-label" $CONFIG)"
export DISRUPTION_COUNT="$($YQ ".scenarios.pod-scenario.disruption-count" $CONFIG)"
export ENABLE_ALERTS="$($YQ ".scenarios.pod-scenario.enable-alerts" $CONFIG)"
export CHECK_CRITICAL_ALERTS="$($YQ ".scenarios.pod-scenario.check-critical-alerts" $CONFIG)"
export EXPECTED_RECOVERY_TIME="$($YQ ".scenarios.pod-scenario.expected-recovery-time" $CONFIG)"

$PODMAN rm --ignore etcd-disruption
$PODMAN run --name=etcd-disruption --net=host --env-host=true -v $KUBECONFIG:/home/krkn/.kube/config:Z  quay.io/krkn-chaos/krkn-hub:pod-scenarios
