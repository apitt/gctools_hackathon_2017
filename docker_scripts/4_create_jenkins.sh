mkdir -p docker/jenkins

eval $(docker-machine env swarm-1)

docker pull jenkins:2.7.4-alpine 

docker service create --name jenkins \
    -p 8082:8080 \
    -p 50000:50000 \
    -e JENKINS_OPTS="--prefix=/jenkins" \
    --mount "type=bind,source=$PWD/docker/jenkins,target=/var/jenkins_home" \
    --reserve-memory 300m \
    jenkins:2.7.4-alpine

echo "Sleeping for 300 seconds to let Jenkins install itself on the file system....its so slow"

sleep 300

# docker-compose -f ./jenkins/jenkins-agent.yml up


TEMP_JENKINS_PASSWORD=$(cat docker/jenkins/secrets/initialAdminPassword)

echo ">> Jenkins tempory password: $TEMP_JENKINS_PASSWORD"

ADMIN_PASSWORD=$(openssl rand -base64 32) 
ADMIN_PASSWORD=admin

echo ">> Please use the following for your new password (do not forget it): $ADMIN_PASSWORD"
echo "##############################"
echo "##############################"
echo ">> Please install the jenkins self-organizing swarm plugin"
echo "##############################"
echo "##############################"


