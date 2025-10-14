#!/bin/bash
source ../env.sh

export NAMESPACE="$($YQ ".scenarios.pod-network-filter.namespace" $CONFIG)"
export POD_SELECTOR="$($YQ ".scenarios.pod-network-filter.pod-selector" $CONFIG)"
export INSTANCE_COUNT="$($YQ ".scenarios.pod-network-filter.instance-count" $CONFIG)"
export ENABLE_ALERTS="$($YQ ".scenarios.pod-network-filter.enable-alerts" $CONFIG)"
export CHECK_CRITICAL_ALERTS="$($YQ ".scenarios.pod-network-filter.check-critical-alerts" $CONFIG)"
export HEALTH_CHECK_URL="$($YQ ".scenarios.pod-network-filter.check.service-url" $CONFIG)"
export INGRESS="$($YQ ".scenarios.pod-network-filter.ingress" $CONFIG)"
export EGRESS="$($YQ ".scenarios.pod-network-filter.ingress" $CONFIG)"
export PORTS="$($YQ ".scenarios.pod-network-filter.ports" $CONFIG)"
export PROTOCOLS="$($YQ ".scenarios.pod-network-filter.protocols" $CONFIG)"
export DURATION="$($YQ ".scenarios.pod-network-filter.duration" $CONFIG)"


$KRKNCTL run pod-network-filter \
    --kubeconfig "../kubeconfig" \
    --namespace "$NAMESPACE"  \
    --chaos-duration "$DURATION" \
    --wait-duration "1" \
    --pod-selector "$POD_SELECTOR"  \
    --instance-count "$INSTANCE_COUNT" \
    --enable-alerts "$ENABLE_ALERTS" \
    --check-critical-alerts "$CHECK_CRITICAL_ALERTS" \
    --health-check-url "$HEALTH_CHECK_URL" \
    --ingress "$INGRESS" \
    --egress "$EGRESS" \
    --ports "$PORTS" \
    --protocols "$PROTOCOLS"