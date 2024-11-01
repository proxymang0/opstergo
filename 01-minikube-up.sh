#!/usr/bin/env bash

set -e

# Load variables
source ./_init_variables.sh

# Check for minikube
if ! command -v minikube &> /dev/null; then
    echo "Could not find minikube on machine. Please install it first."
    exit 100
fi

# Check for kubectl
if ! command -v kubectl &> /dev/null; then
    echo "Could not find kubectl on machine. Please install it first."
    exit 101
fi

# Set the appropriate VM driver based on the operating system
case "$(uname -s)" in
   Darwin*)
     minikube config set vm-driver hyperkit
     ;;
   *)
     minikube config set vm-driver virtualbox
     ;;
esac

# Start minikube with specified Kubernetes version and nodes
if ! minikube status &> /dev/null; then
    minikube start --kubernetes-version "${KUBERNETES_VERSION}" --nodes 2
else
    echo "Minikube is already running."
fi

# Enable metrics server
minikube addons enable metrics-server

# Get Minikube IP
MINIKUBE_IP=$(minikube ip)

echo
echo "Cool! Minikube is up on ${MINIKUBE_IP} address."
