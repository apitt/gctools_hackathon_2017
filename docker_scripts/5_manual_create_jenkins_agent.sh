eval $(docker-machine env swarm-test-1)

#echo $ADMIN_PASSWORD | docker secret create JIRA_PASSWORD -

docker-machine ssh swarm-test-1

sudo mount -t / / -o remount,size=1250M  
sudo mkdir /workspace && sudo chmod 777 /workspace && exit

export USER=admin

export PASSWORD=admin

docker pull vfarcic/jenkins-swarm-agent

docker service create --name jenkins-agent \
    -e COMMAND_OPTIONS="-master \
    http://$(docker-machine ip swarm-1):8082/jenkins \
    -username $USER -password $PASSWORD \
    -labels 'docker' -executors 5" \
    --mode global \
    --constraint 'node.labels.env == jenkins-agent' \
    --mount "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock" \
    --mount "type=bind,source=$HOME/.docker/machine/machines,target=/machines" \
    --mount "type=bind,source=/workspace,target=/workspace" \
    vfarcic/jenkins-swarm-agent

