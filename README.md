# opstergo
Redis HA Kubernetes Setup with Minikube
set of scripts for deploying a (HA) Redis master-slave setup in Kubernetes using Minikube. 
Need to have minikube and kubectl pre installed.

01-minikube-up.sh - Initializes Minikube with two nodes.

02-redis-up.sh - Deploys Redis master-slave on Kubernetes.

03-redis-import.sh - Imports data to the Redis master from import/redis/data.txt.

97-redis-clean.sh - Clears all data from Redis master.

98-redis-down.sh - Deletes Redis-related Kubernetes resources.

99-minikube-down.sh - Shuts down and removes the Minikube environment.

_dev_vars.sh - Exports environment variables for Redis master and slave external access.

_init_variables.sh - Initializes required environment variables.
