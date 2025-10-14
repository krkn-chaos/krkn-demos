#!/bin/bash
source ../env.sh

export NAMESPACE="$($YQ ".scenarios.pod-scenario.namespace" $CONFIG)"
export POD_LABEL="$($YQ ".scenarios.pod-scenario.pod-label" $CONFIG)"
export DISRUPTION_COUNT="$($YQ ".scenarios.pod-scenario.disruption-count" $CONFIG)"
export ENABLE_ALERTS="$($YQ ".scenarios.pod-scenario.enable-alerts" $CONFIG)"
export CHECK_CRITICAL_ALERTS="$($YQ ".scenarios.pod-scenario.check-critical-alerts" $CONFIG)"
export EXPECTED_RECOVERY_TIME="$($YQ ".scenarios.pod-scenario.expected-recovery-time" $CONFIG)"
export HEALTH_CHECK_URL="$($YQ ".scenarios.pod-scenario.check.service-url" $CONFIG)"

$KRKNCTL run pod-scenarios \
    --kubeconfig "../kubeconfig" \
    --namespace "$NAMESPACE"  \
    --pod-label "$POD_LABEL"  \
    --disruption-count "$DISRUPTION_COUNT" \
    --enable-alerts "$ENABLE_ALERTS" \
    --check-critical-alerts "$CHECK_CRITICAL_ALERTS" \
    --health-check-url "$HEALTH_CHECK_URL" \
    --expected-recovery-time "$EXPECTED_RECOVERY_TIME" 

