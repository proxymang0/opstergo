#!/usr/bin/env sh

set -e

# Define minikube path explicitly
MINIKUBE_PATH="/usr/local/bin/minikube"

# Check if minikube exists at specified path
if [ ! -x "$MINIKUBE_PATH" ]; then
    echo "Minikube not executable at $MINIKUBE_PATH. Please check installation."
    exit 1
fi

# Delete minikube and its context
"$MINIKUBE_PATH" delete || echo "Minikube was not running or already deleted."
kubectl config delete-context minikube || echo "Minikube context already deleted."

echo "Minikube and its context have been deleted."
