#!/bin/bash
source ./env.sh

$PODMAN rm --ignore zone-outages 

$PODMAN run --name=zone-outages --net=host -e  CLOUD_TYPE="$($YQ ".scenarios.zone-outage.cloud-type" $CONFIG)" -e DURATION="$($YQ ".scenarios.zone-outage.duration" $CONFIG)" -e VPC_ID="$($YQ ".scenarios.zone-outage.vpc-id" $CONFIG)" -e SUBNET_ID="[$($YQ ".scenarios.zone-outage.subnet-id" $CONFIG)]" -e AWS_DEFAULT_REGION="$($YQ ".scenarios.zone-outage.region" $CONFIG)" -e AWS_ACCESS_KEY_ID="$($YQ ".aws.access-key-id" $CONFIG)" -e AWS_SECRET_ACCESS_KEY="$($YQ ".aws.secret-access-key" $CONFIG)" -v $KUBECONFIG:/home/krkn/.kube/config:Z quay.io/krkn-chaos/krkn-hub:zone-outages
