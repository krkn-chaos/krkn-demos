#!/bin/bash 
source ./env.sh

export ACTION="$($YQ ".scenarios.node-outage.action" $CONFIG)"
export LABEL_SELECTOR="$($YQ ".scenarios.node-outage.label-selector" $CONFIG)" 
export INSTANCE_COUNT="$($YQ ".scenarios.node-outage.instance-count" $CONFIG)"
export RUNS="$($YQ ".scenarios.node-outage.runs" $CONFIG)"
export CLOUD_TYPE="$($YQ ".scenarios.node-outage.cloud-type" $CONFIG)"
export DURATION="$($YQ ".scenarios.node-outage.duration" $CONFIG)"
export AWS_DEFAULT_REGION="$($YQ ".aws.region" $CONFIG)"
export AWS_ACCESS_KEY_ID="$($YQ ".aws.access-key-id" $CONFIG)"
export AWS_SECRET_ACCESS_KEY="$($YQ ".aws.secret-access-key" $CONFIG)"
$PODMAN rm --ignore  master-node-outage
$PODMAN run --name=master-node-outage --net=host --env-host=true -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:node-scenarios
