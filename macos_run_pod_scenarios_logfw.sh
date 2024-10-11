#!/bin/bash
source ./env.sh

$PODMAN rm --ignore "$($YQ ".scenarios.pod-scenario.namespace" $CONFIG)"-disruption

$PODMAN run --log-driver=json-file --log-opt path=/Users/agabriel/Documents/reports/kraken.logs --name="$($YQ ".scenarios.pod-scenario.namespace" $CONFIG)"-disruption --net=host --env NAMESPACE="$($YQ ".scenarios.pod-scenario.namespace" $CONFIG)" --env POD_LABEL="$($YQ ".scenarios.pod-scenario.pod-label" $CONFIG)" --env DISRUPTION_COUNT="$($YQ ".scenarios.pod-scenario.disruption-count" $CONFIG)" --env ENABLE_ALERTS="$($YQ ".scenarios.pod-scenario.enable-alerts" $CONFIG)" --env CHECK_CRITICAL_ALERTS="$($YQ ".scenarios.pod-scenario.check-critical-alerts" $CONFIG)" --env EXPECTED_RECOVERY_TIME="$($YQ ".scenarios.pod-scenario.expected-recovery-time" $CONFIG)"  -v $KUBECONFIG:/home/krkn/.kube/config:Z  quay.io/krkn-chaos/krkn-hub:pod-scenarios
