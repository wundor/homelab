#!/bin/bash
# This is useful when you have swarm cluster of several machines: simply use this on the manager node like this - ./swarm-exec.sh STACK_SERVICE COMMAND - manager node should have ssh access to all workers for this to work
set -e

SERVICE_NAME=$1; shift

TASK_ID=$(docker service ps --filter 'desired-state=running' $SERVICE_NAME -q)
NODE_ID=$(docker inspect --format '{{ .NodeID }}' $TASK_ID)
CONTAINER_ID=$(docker inspect --format '{{ .Status.ContainerStatus.ContainerID }}' $TASK_ID)
NODE_HOST=$(docker node inspect --format '{{ .Description.Hostname }}' $NODE_ID)
export DOCKER_HOST="ssh://ci@$NODE_HOST"
echo "executing on $NODE_HOST"
docker exec -it $EXEC_FLAGS $CONTAINER_ID "$@"