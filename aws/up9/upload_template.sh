#!/bin/bash

TEMPLATE_NAME=$1

TEMPLATE_LOCAL_PATH=$TEMPLATE_NAME.yaml
TEMPLATE_S3_PATH=up9/templates/$TEMPLATE_NAME
TEMPLATE_URL_UPLOAD=s3://$TEMPLATE_S3_PATH

aws s3 cp $TEMPLATE_LOCAL_PATH $TEMPLATE_URL_UPLOAD
