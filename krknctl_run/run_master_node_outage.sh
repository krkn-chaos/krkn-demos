#!/bin/bash

source ./env.sh
[ -z "$(which krknctl)" ] && echo "krknctl not found or not installed" && exit 1

ACTION="$($YQ ".scenarios.node-outage.action" $CONFIG)"
LABEL_SELECTOR="$($YQ ".scenarios.node-outage.label-selector" $CONFIG)"
INSTANCE_COUNT="$($YQ ".scenarios.node-outage.instance-count" $CONFIG)"
RUNS="$($YQ ".scenarios.node-outage.runs" $CONFIG)"
CLOUD_TYPE="$($YQ ".scenarios.node-outage.cloud-type" $CONFIG)"
DURATION="$($YQ ".scenarios.node-outage.duration" $CONFIG)"
AWS_DEFAULT_REGION="$($YQ ".aws.region" $CONFIG)"
AWS_ACCESS_KEY_ID="$($YQ ".aws.access-key-id" $CONFIG)"
AWS_SECRET_ACCESS_KEY="$($YQ ".aws.secret-access-key" $CONFIG)"

set -x
krknctl run node-scenarios \
  --action "$ACTION" \
  --label-selector "$LABEL_SELECTOR" \
  --instance-count "$INSTANCE_COUNT" \
  --runs "$RUNS" \
  --cloud-type "$CLOUD_TYPE" \
  --duration "$DURATION" \
  --aws-default-region "$AWS_DEFAULT_REGION" \
  --aws-access-key-id "$AWS_ACCESS_KEY_ID" \
  --aws-secret-access-key "$AWS_SECRET_ACCESS_KEY" \
  --wait-duration "$WAIT_DURATION"
set +x
