#!/bin/bash
source ./env.sh

$PODMAN rm --ignore zone-outages

$PODMAN run --name=zone-outages \
  --net=host \
  --env CLOUD_TYPE="$($YQ ".scenarios.zone-outage.cloud-type" $CONFIG)" \
  --env DURATION="$($YQ ".scenarios.zone-outage.duration" $CONFIG)" \
  --env VPC_ID="$($YQ ".scenarios.zone-outage.vpc-id" $CONFIG)" \
  --env SUBNET_ID="[$($YQ ".scenarios.zone-outage.subnet-id" $CONFIG)]" \
  --env AWS_DEFAULT_REGION="$($YQ ".scenarios.zone-outage.region" $CONFIG)" \
  --env AWS_ACCESS_KEY_ID="$($YQ ".aws.access-key-id" $CONFIG)" \
  --env AWS_SECRET_ACCESS_KEY="$($YQ ".aws.secret-access-key" $CONFIG)" \
  --env WAIT_DURATION="$WAIT_DURATION" \
  -v $KUBECONFIG:/home/krkn/.kube/config:Z \
  quay.io/krkn-chaos/krkn-hub:zone-outages
