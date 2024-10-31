#!/usr/bin/env bash

set -e

# Delete Redis namespace and all its resources
kubectl delete namespace redis || echo "Namespace 'redis' not found."

echo "All Redis resources have been deleted."

