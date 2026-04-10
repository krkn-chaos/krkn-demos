#!/bin/bash

source ./env.sh
[ -z "$(which krknctl)" ] && echo "krknctl not found or not installed" && exit 1

NAMESPACE="$($YQ ".scenarios.pod-scenario.namespace" $CONFIG)"
POD_LABEL="$($YQ ".scenarios.pod-scenario.pod-label" $CONFIG)"
DISRUPTION_COUNT="$($YQ ".scenarios.pod-scenario.disruption-count" $CONFIG)"
ENABLE_ALERTS="$($YQ ".scenarios.pod-scenario.enable-alerts" $CONFIG)"
CHECK_CRITICAL_ALERTS="$($YQ ".scenarios.pod-scenario.check-critical-alerts" $CONFIG)"
EXPECTED_RECOVERY_TIME="$($YQ ".scenarios.pod-scenario.expected-recovery-time" $CONFIG)"

set -x
krknctl run pod-scenarios \
  --namespace "$NAMESPACE" \
  --pod-label "$POD_LABEL" \
  --disruption-count "$DISRUPTION_COUNT" \
  --enable-alerts "$ENABLE_ALERTS" \
  --check-critical-alerts "$CHECK_CRITICAL_ALERTS" \
  --expected-recovery-time "$EXPECTED_RECOVERY_TIME" \
  --wait-duration "$WAIT_DURATION"
set +x
