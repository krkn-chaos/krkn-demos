#!/bin/bash
source ./env.sh

while [ 1 ]; do
$OC exec -n $($YQ ".scenarios.pvc-scenario.namespace" $CONFIG)  $($YQ ".scenarios.pvc-scenario.pod-name" $CONFIG) -c $($YQ ".scenarios.pvc-scenario.check.container-name" $CONFIG) -- "/usr/bin/df" | grep  $($YQ ".scenarios.pvc-scenario.check.block-device" $CONFIG)
sleep 2
done;
