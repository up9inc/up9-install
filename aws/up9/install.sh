#!/bin/bash

STACK_NAME=$1
TEMPLATE_NAME=$2

TEMPLATE_S3_PATH=up9/templates/$TEMPLATE_NAME
TEMPLATE_URL=https://s3.eu-central-1.amazonaws.com/$TEMPLATE_S3_PATH

aws cloudformation create-stack --capabilities CAPABILITY_IAM --stack-name $STACK_NAME --template-url $TEMPLATE_URL --parameters "$(cat ${TEMPLATE_NAME}_values.json)" | cat
