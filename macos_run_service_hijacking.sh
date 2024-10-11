#!/bin/bash
source ./env.sh

PLAN_FILE=$(pwd)/$($YQ ".scenarios.service-hijacking.plan-file" $CONFIG)

[ ! -f $PLAN_FILE ] && echo "plan file $PLAN_FILE not found" && exit 1
$YQ -i ".service_target_port = $($YQ ".scenarios.service-hijacking.service-target-port" $CONFIG)" $PLAN_FILE
$YQ -i ".service_name = \"$($YQ ".scenarios.service-hijacking.service-name" $CONFIG)\"" $PLAN_FILE
$YQ -i ".service_namespace = \"$($YQ ".scenarios.service-hijacking.namespace" $CONFIG)\"" $PLAN_FILE
$YQ -i ".chaos_duration = $($YQ ".scenarios.service-hijacking.duration" $CONFIG)" $PLAN_FILE

$PODMAN rm --ignore service-hijacking

$PODMAN run --name=service-hijacking \
              -e SCENARIO_BASE64="$($BASE64 -w0 < $PLAN_FILE)" \
	      -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:service-hijacking

