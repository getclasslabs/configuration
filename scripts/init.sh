#!/bin/bash

echo "Checking Swarm network"
if ! docker node ls &>/dev/null ; then
    docker swarm init
fi
if ! docker network inspect main &>/dev/null ; then
    docker network create -d overlay main
fi

docker stack deploy -c kong/docker-compose.yaml gcl