#!/usr/bin/env bash

if [[ "$(uname -s )" == "Linux" ]]; then
  export VIRTUALBOX_SHARE_FOLDER="$PWD:$PWD"
fi

for i in 1 2 3; do
    docker-machine create \
        -d virtualbox \
        --virtualbox-memory 512 \
        --engine-opt experimental=true \
        swarm-test-$i
done

eval $(docker-machine env swarm-test-1)

docker swarm init \
    --advertise-addr $(docker-machine ip swarm-test-1)
    --listen-addr $(docker-machine ip swarm-test-1):2377

echo ">> Labeling swarm-test-1 as a jenkins-agent"
docker node update \
    --label-add env=jenkins-agent \
    swarm-test-1

TOKEN=$(docker swarm join-token -q manager)

for i in 2 3; do
    eval $(docker-machine env swarm-test-$i)

    docker swarm join \
        --token $TOKEN \
        --advertise-addr $(docker-machine ip swarm-test-$i) \
        $(docker-machine ip swarm-test-1):2377

    echo ">> Labeling the other test swarm servers as prod-like"
    docker node update \
        --label-add env=prod-like \
        swarm-test-$i
done

echo ">> The test swarm cluster is up and running"

