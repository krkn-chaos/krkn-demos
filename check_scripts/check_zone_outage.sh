#!/bin/bash
source ./env.sh

$WATCH -n1 "$AWS ec2 describe-network-acls --filters \"Name=association.subnet-id,Values=$($YQ ".scenarios.zone-outage.subnet-id" $CONFIG)\" --query \"NetworkAcls[*].Entries[*].{RuleNumber:RuleNumber, Protocol:Protocol, Action:RuleAction, Egress:Egress, Cidr:CidrBlock}\" --output table"
