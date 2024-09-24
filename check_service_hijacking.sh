#!/bin/bash
source ./env.sh

$WATCH -n 1 $CURL -m 2 -s $($YQ ".scenarios.service-hijacking.check.service-url" $CONFIG) -w "STATUS_CODE:%{http_code}"
