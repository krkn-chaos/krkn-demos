#!/bin/bash

source ./env.sh
[ -z "$(which krknctl)" ] && echo "krknctl not found or not installed" && exit 1

PLAN_FILE=$(pwd)/$($YQ ".scenarios.service-hijacking.plan-file" $CONFIG)
[ ! -f $PLAN_FILE ] && echo "plan file $PLAN_FILE not found" && exit 1

$YQ -i ".service_target_port = $($YQ ".scenarios.service-hijacking.service-target-port" $CONFIG)" $PLAN_FILE
$YQ -i ".service_name = \"$($YQ ".scenarios.service-hijacking.service-name" $CONFIG)\"" $PLAN_FILE
$YQ -i ".service_namespace = \"$($YQ ".scenarios.service-hijacking.namespace" $CONFIG)\"" $PLAN_FILE
$YQ -i ".chaos_duration = \"$($YQ ".scenarios.service-hijacking.duration" $CONFIG)\"" $PLAN_FILE

set -x
krknctl run service-hijacking \
  --scenario-file-path "$PLAN_FILE" \
  --wait-duration "$WAIT_DURATION"
set +x
