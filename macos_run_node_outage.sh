#!/bin/bash 
source ./env.sh

$PODMAN rm --ignore  master-node-outage

$PODMAN run --name=node-outage --net=host --env ACTION="$($YQ ".scenarios.node-outage.action" $CONFIG)" --env LABEL_SELECTOR="$($YQ ".scenarios.node-outage.label-selector" $CONFIG)" --env INSTANCE_COUNT="$($YQ ".scenarios.node-outage.instance-count" $CONFIG)" --env RUNS="$($YQ ".scenarios.node-outage.runs" $CONFIG)" --env CLOUD_TYPE="$($YQ ".scenarios.node-outage.cloud-type" $CONFIG)" --env DURATION="$($YQ ".scenarios.node-outage.duration" $CONFIG)" --env AWS_DEFAULT_REGION="$($YQ ".aws.region" $CONFIG)" --env AWS_ACCESS_KEY_ID="$($YQ ".aws.access-key-id" $CONFIG)" --env AWS_SECRET_ACCESS_KEY="$($YQ ".aws.secret-access-key" $CONFIG)"  -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:node-scenarios
