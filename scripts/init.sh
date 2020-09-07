#!/bin/bash

apisToDeploy=( "user" )

echo "Checking Swarm network"
if ! docker node ls &>/dev/null ; then
    docker swarm init
fi
if ! docker network inspect main &>/dev/null ; then
    docker network create -d overlay main
fi

echo "Deploying Kong"
docker stack deploy -c kong/docker-compose.yaml gcl

echo "Deploying jaeger"
docker stack deploy -c jaeger/docker-compose.yaml gcl

echo "Deploying database"
docker stack deploy -c mysql/docker-compose.yaml gcl

echo "Deploying APIs"
[ -z "$GETCLASSAPIS" ] && apis="../apis" || apis="$GETCLASSAPIS"
cd $apis

for api in "${apisToDeploy}" 
do
    (cd $api && make;)
done
