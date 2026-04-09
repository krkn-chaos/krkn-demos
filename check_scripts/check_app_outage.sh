#!/bin/bash
source ./env.sh

$WATCH -n1 "$CURL -I -s --connect-timeout 2 -m 2 $($YQ ".scenarios.app-outage.check.service-url" $CONFIG)"
