#!/bin/bash
source ./env.sh

export CLOUD_TYPE="$($YQ ".scenarios.zone-outage.cloud-type" $CONFIG)"
export DURATION="$($YQ ".scenarios.zone-outage.duration" $CONFIG)"
export VPC_ID="$($YQ ".scenarios.zone-outage.vpc-id" $CONFIG)"
export SUBNET_ID="[$($YQ ".scenarios.zone-outage.subnet-id" $CONFIG)]"
export AWS_DEFAULT_REGION="$($YQ ".scenarios.zone-outage.region" $CONFIG)"
export AWS_ACCESS_KEY_ID="$($YQ ".aws.access-key-id" $CONFIG)"
export AWS_SECRET_ACCESS_KEY="$($YQ ".aws.secret-access-key" $CONFIG)"

$PODMAN rm --ignore zone-outages 
$PODMAN run --name=zone-outages --net=host --env-host=true -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:zone-outages
