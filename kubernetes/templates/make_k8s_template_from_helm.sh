#!/bin/bash 

######
#
# Use this script to generate UP9 setup for "vanilla" Kubernetes
#
# Example:
#   generate_k8s_yaml.sh -i xxx-xxx -s yyy-yyy -a zzz
#
# where 
#   xxx-xxx is the Client Id retrieved from UP9 CLI or GUI
#   yyy-yyy is the Client Secret retrieved from UP9 CLI or GUI
#   zzz is (optional) agent name 
#
# for more information please refer to https://docs.up9.com/
#
######

SCRIPT_NAME=$0
AGENT_NAME=up9-$$
CLIENT_ID=""
CLIENT_SECRET=""
DEFAULT_MODEL="default"
OUTPUT_FILE=up9.$$.yaml

print_usage_and_exit() {
    echo ""
    echo "Usage:"
    echo "   $1 -i ID -s SECRET -a AGENT"
    echo "or "
    echo "  $1 --clientid ID --secret SECRET --agent AGENT"
    echo ""
    exit
}

if [ "$#" -eq "0" ]; then 
    print_usage_and_exit ${SCRIPT_NAME}
fi

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -i|--clientid)
    CLIENT_ID="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--secret)
    CLIENT_SECRET="$2"
    shift # past argument
    shift # past value
    ;;
    -a|--agent)
    AGENT_NAME="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    echo "Unknown option"
    print_usage_and_exit ${SCRIPT_NAME}
    shift # past argument
    ;;
esac
done

if [ -z "${CLIENT_ID}" ] || [ -z "${CLIENT_SECRET}" ] || [ -z "${AGENT_NAME}" ]; then
    echo "Missing option"
    print_usage_and_exit ${SCRIPT_NAME}
fi

echo ""
echo "Generating UP9 setup with following details:"
echo ""
echo "CLIENT_ID         = ${CLIENT_ID}"
echo "CLIENT_SECRET     = ${CLIENT_SECRET}"
echo "AGENT_NAME        = ${AGENT_NAME}"
echo ""

helm template --repo https://static.up9.com/helm/ up9agent up9 \
    --set clientId=${CLIENT_ID} \
    --set clientSecret=${CLIENT_SECRET} \
    --set agentName=${AGENT_NAME} > ${OUTPUT_FILE}

echo -e "UP9 setup for K8S is saved to file \033[0;36m ${OUTPUT_FILE} \033[0m"
echo -e "Run \033[1;33m kubectl apply -f ${OUTPUT_FILE} \033[0m to deploy"
echo ""
