#!/bin/bash

STACK_NAME=$1
TEMPLATE_NAME=$2

TEMPLATE_PATH=$TEMPLATE_NAME.yaml

aws cloudformation create-stack --capabilities CAPABILITY_IAM --stack-name $STACK_NAME --template-body "$(cat $TEMPLATE_PATH)" --parameters "$(cat ${TEMPLATE_NAME}_values.json)" | cat
