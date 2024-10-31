#!/usr/bin/env bash

set -e

# Clean data in Redis master
kubectl -n redis exec -i $(kubectl -n redis get pods -l app=redis-master -o jsonpath='{.items[0].metadata.name}') -- redis-cli FLUSHALL
echo "Data cleaned from Redis master."
