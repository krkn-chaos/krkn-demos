#!/bin/bash
source ../env.sh

export NAMESPACE="$($YQ ".scenarios.pod-network-filter.namespace" $CONFIG)"
export POD_LABEL="$($YQ ".scenarios.pod-network-filter.pod-label" $CONFIG)"
export INSTANCE_COUNT="$($YQ ".scenarios.pod-network-filter.instance-count" $CONFIG)"
export ENABLE_ALERTS="$($YQ ".scenarios.pod-network-filter.enable-alerts" $CONFIG)"
export CHECK_CRITICAL_ALERTS="$($YQ ".scenarios.pod-network-filter.check-critical-alerts" $CONFIG)"
export HEALTH_CHECK_URL="$($YQ ".scenarios.pod-network-filter.check.service-url" $CONFIG)"
export INGRESS="$($YQ ".scenarios.pod-network-filter.ingress" $CONFIG)"
export EGRESS="$($YQ ".scenarios.pod-network-filter.ingress" $CONFIG)"
export PORTS="$($YQ ".scenarios.pod-network-filter.ports" $CONFIG)"
export PROTOCOLS="$($YQ ".scenarios.pod-network-filter.protocols" $CONFIG)"


$KRKNCTL run pod-network-filters \
    --kubeconfig "../kubeconfig" \
    --namespace "$NAMESPACE"  \
    --pod-selector "$POD_LABEL"  \
    --instance-count "$INSTANCE_COUNT" \
    --enable-alerts "True" \
    --check-critical-alerts "True" \
    --health-check-url "$HEALTH_CHECK_URL" \
    --ingress "$INGRESS" \
    --egress "$EGRESS" \
    --ports "$PORTS" \
    --protocols "$PROTOCOLS"