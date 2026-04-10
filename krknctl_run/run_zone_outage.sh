#!/bin/bash

source ./env.sh
[ -z "$(which krknctl)" ] && echo "krknctl not found or not installed" && exit 1

CLOUD_TYPE="$($YQ ".scenarios.zone-outage.cloud-type" $CONFIG)"
DURATION="$($YQ ".scenarios.zone-outage.duration" $CONFIG)"
VPC_ID="$($YQ ".scenarios.zone-outage.vpc-id" $CONFIG)"
SUBNET_ID="[$($YQ ".scenarios.zone-outage.subnet-id" $CONFIG)]"
AWS_DEFAULT_REGION="$($YQ ".scenarios.zone-outage.region" $CONFIG)"
AWS_ACCESS_KEY_ID="$($YQ ".aws.access-key-id" $CONFIG)"
AWS_SECRET_ACCESS_KEY="$($YQ ".aws.secret-access-key" $CONFIG)"

set -x
krknctl run zone-outages \
  --cloud-type "$CLOUD_TYPE" \
  --duration "$DURATION" \
  --vpc-id "$VPC_ID" \
  --subnet-id "$SUBNET_ID" \
  --aws-default-region "$AWS_DEFAULT_REGION" \
  --aws-access-key-id "$AWS_ACCESS_KEY_ID" \
  --aws-secret-access-key "$AWS_SECRET_ACCESS_KEY" \
  --wait-duration "$WAIT_DURATION"
set +x
