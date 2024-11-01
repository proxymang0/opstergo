#!/usr/bin/env bash

set -e

# Import data into Redis master
kubectl -n redis exec -i $(kubectl -n redis get pods -l app=redis-master -o jsonpath='{.items[0].metadata.name}') -- redis-cli < import/redis/data.txt
echo "Data imported into Redis master."
