#!/usr/bin/env bash

eval $(docker-machine env swarm-1)

docker network create --driver overlay proxy

docker network create --driver overlay logs

docker network create --driver overlay internal_gcpedia_network

docker network create --driver overlay code-network

docker stack deploy -c docker-compose-stack.yml proxy

eval $(docker-machine env swarm-1)

docker service create --name registry \
    -p 5000:5000 \
    --reserve-memory 100m \
    --mount "type=bind,source=$PWD,target=/var/lib/registry" \
    registry:2.5.0


eval $(docker-machine env swarm-test-1)

docker service create --name registry \
    -p 5000:5000 \
    --reserve-memory 100m \
    --mount "type=bind,source=$PWD,target=/var/lib/registry" \
    registry:2.5.0