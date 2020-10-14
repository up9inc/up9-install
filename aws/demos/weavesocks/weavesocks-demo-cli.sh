#!/bin/bash
PEM=weavesocks-demo-key
STACK_NAME=weavesocks-demo

function deploy
{
	if [ -e "./$PEM.pem" ]
	then
		printf "You already have an existing key ./$PEM.pem, you can either delete your pem or update this script and rename the PEM\n"
		exit
	fi

	aws ec2 describe-key-pairs --key-names $PEM &>/dev/null
	if [ $? -ne 0 ]; then
		printf "Key pair '$PEM' does not exist, creating\n"
	else
		printf "You already have an existing aws key pair '$PEM', you can either delete your aws key pair or update this script and rename the PEM\n"
		exit
	fi
  printf "Creating key-pair $PEM\n"
	aws ec2 create-key-pair --key-name $PEM --query 'KeyMaterial' --output text > ./$PEM.pem
	chmod 600 ./$PEM.pem
  printf "key-pair PEM file saved at ./$PEM.pem\n"

	printf "Creating stack $STACK_NAME\n"
	aws cloudformation create-stack --capabilities CAPABILITY_IAM --stack-name weavesocks-demo --template-body "$(cat weavesocks.yaml)" --parameters '[{"ParameterKey": "KeyPairName", "ParameterValue": "weavesocks-demo-key"}]'
	printf "Stack creation has been started, watching stack status...\n"
	get_status
}

function get_status
{
	printf "Stack Status:\n"
	while :
	do
		stat=$(aws cloudformation describe-stacks --stack-name $STACK_NAME  | jq -r '.Stacks[0].StackStatus' )
		case $stat in

	        	CREATE_IN_PROGRESS )	printf "Create in Progress\n"
						sleep 2
                                		;;

	        	DELETE_IN_PROGRESS )	printf "Destroy in Progress\n"
						sleep 2
                                		;;

		        CREATE_COMPLETE )	printf "Creation Complete\n"
		        getresources
						getdns
						exit
                                		;;

		        DESTROY_COMPLETE )	printf "Destroy Complete\n"
						exit
                                		;;

			* )			printf "Unexpected status $stat\n"
						exit

		esac
	done

}

function getdns
{
	LOAD_BALANCE_ID=$(aws cloudformation describe-stack-resources --stack-name $STACK_NAME --logical-resource-id FrontendLoadBalancer | jq -r '.StackResources[0].PhysicalResourceId' )
  DNS=$(aws elbv2 describe-load-balancers --load-balancer-arns $LOAD_BALANCE_ID | jq -r '.LoadBalancers[0].DNSName' )
  printf "Weavesocks is accessible at\n$DNS\n"
}

function getresources {
  VPC_ID=$(aws cloudformation describe-stack-resources --stack-name weavesocks-demo --logical-resource-id Vpc | jq -r '.StackResources[0].PhysicalResourceId')
  SUBNET_ID=$(aws cloudformation describe-stack-resources --stack-name weavesocks-demo --logical-resource-id Subnet0 | jq -r '.StackResources[0].PhysicalResourceId')
  CLUSTER_NAME=$(aws cloudformation describe-stack-resources --stack-name weavesocks-demo --logical-resource-id ECSCluster |jq -r '.StackResources[0].PhysicalResourceId')
  printf "\nvpc: $VPC_ID\n"
  printf "subnet: $SUBNET_ID\n"
  printf "cluster name: $CLUSTER_NAME\n\n"
}

function destroy
{
	printf "Requesting stack be destroyed\n"
	aws cloudformation delete-stack --stack-name $STACK_NAME
	printf "Deleting key pair '$PEM'\n"
	aws ec2 delete-key-pair --key-name $PEM
	printf "Removing pem file ./$PEM.pem\n"
	rm ./$PEM.pem
	printf "Watching stack status...\n"
	get_status
}

case $1 in
	        deploy )			deploy
					exit
                                	;;

	        destroy )		destroy
					exit
                                	;;

	        status )		get_status
					exit
                                	;;

	        dns )			getdns
					exit
                                	;;
	        resources )			getresources
					exit
                                	;;
		* )			printf "Invalid Operation\n"
					exit
					;;

esac