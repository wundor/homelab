#!/bin/bash
set -e

SERVICE_NAME=$1; shift

TASK_ID=$(docker service ps --filter 'desired-state=running' $SERVICE_NAME -q)
NODE_ID=$(docker inspect --format '{{ .NodeID }}' $TASK_ID)
CONTAINER_ID=$(docker inspect --format '{{ .Status.ContainerStatus.ContainerID }}' $TASK_ID)
NODE_HOST=$(docker node inspect --format '{{ .Description.Hostname }}' $NODE_ID)
export DOCKER_HOST="ssh://ci@$NODE_HOST"
docker exec -it $EXEC_FLAGS $CONTAINER_ID "$@"