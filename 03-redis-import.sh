#!/usr/bin/env bash

set -e

# Load variables
source ./_init_variables.sh

# Get the name of the redis-master pod
REDIS_MASTER_POD=$(kubectl -n redis get pods -l app=redis-master -o jsonpath='{.items[0].metadata.name}')

# Get the container name inside the redis-master pod
CONTAINER_NAME=$(kubectl -n redis get pod "$REDIS_MASTER_POD" -o jsonpath='{.spec.containers[0].name}')

# Import data into Redis master
kubectl -n redis exec -i "$REDIS_MASTER_POD" -c "$CONTAINER_NAME" -- redis-cli < import/redis/data.txt

echo "Data imported into Redis master."
