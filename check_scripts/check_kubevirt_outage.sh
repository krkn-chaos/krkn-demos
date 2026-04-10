#!/bin/bash
source ./env.sh

$WATCH -n1 $OC get vmi -n $($YQ ".scenarios.kubevirt-outage.namespace" $CONFIG)
