#!/usr/bin/env bash

set -e

# Load variables
source ./_init_variables.sh

# Create Redis namespace if it doesn't exist
kubectl create namespace redis || echo "Namespace 'redis' already exists."

# Deploy Redis master with persistent storage
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: redis-master
  namespace: redis
spec:
  serviceName: redis-master
  replicas: 1
  selector:
    matchLabels:
      app: redis-master
  template:
    metadata:
      labels:
        app: redis-master
    spec:
      containers:
      - name: redis
        image: redis:latest
        ports:
        - containerPort: 6379
        volumeMounts:
        - name: redis-master-storage
          mountPath: /data
        command: ["redis-server", "--appendonly", "yes"]
      volumes:
      - name: redis-master-storage
        persistentVolumeClaim:
          claimName: redis-master-pvc
---
apiVersion: v1
kind: Service
metadata:
  name: redis-master
  namespace: redis
spec:
  ports:
  - port: 6379
    targetPort: 6379
  clusterIP: None
  selector:
    app: redis-master
EOF

# Create persistent volume claim for Redis master
kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: redis-master-pvc
  namespace: redis
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
EOF

# Deploy Redis slave
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-slave
  namespace: redis
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis-slave
  template:
    metadata:
      labels:
        app: redis-slave
    spec:
      containers:
      - name: redis
        image: redis:latest
        ports:
        - containerPort: 6379
        command: ["redis-server", "--slaveof", "redis-master", "6379"]
---
apiVersion: v1
kind: Service
metadata:
  name: redis-slave
  namespace: redis
spec:
  ports:
  - port: 6379
    targetPort: 6379
  selector:
    app: redis-slave
EOF

echo "Redis master and slave have been deployed."

