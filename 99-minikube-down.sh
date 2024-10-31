#!/usr/bin/env sh

set -e

# Check for minikube
if ! command -v minikube &> /dev/null; then
    echo "Could not find minikube on machine. Please install it first."
    exit 1
fi

# Check for kubectl
if ! command -v kubectl &> /dev/null; then
    echo "Could not find kubectl on machine. Please install it first."
    exit 2
fi

# Delete minikube and clean up
minikube delete
kubectl config delete-context minikube

echo "Minikube and its context have been deleted."
