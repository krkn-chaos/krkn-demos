#!/bin/bash
source ./env.sh

$WATCH -n1 $OC get pods -n $($YQ ".scenarios.pod-scenario.namespace" $CONFIG)
