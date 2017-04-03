
docker service create --name util --network proxy --mode global alpine sleep 1000000000
ID=$(docker ps -q --filter label=com.docker.swarm.service.name=util)

docker exec -it $ID apk add --update drill
docker exec -it $ID drill gcpedia
curl -i "localhost/"