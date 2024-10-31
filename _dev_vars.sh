#!/usr/bin/env bash

# Set environment variables for Redis master and slave
export REDIS_MASTER_HOST_PORT=$(minikube ip):$(kubectl get svc redis-master -n redis -o jsonpath='{.spec.ports[0].port}')
export REDIS_SLAVE_HOST_PORT=$(minikube ip):$(kubectl get svc redis-slave -n redis -o jsonpath='{.spec.ports[0].port}')

# Verify the variables are set correctly
echo "REDIS_MASTER_HOST_PORT=${REDIS_MASTER_HOST_PORT}"
echo "REDIS_SLAVE_HOST_PORT=${REDIS_SLAVE_HOST_PORT}"
