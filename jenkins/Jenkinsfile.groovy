node("docker") {

  stage("Pull") {
    git "https://github.com/docker/dockercloud-hello-world.git"
    //git "https://github.com/demiantradel/gctools_hackathon_2017.git"
    // git branch: 'master', credentialsId: '73b6a5f2-f9be-41cd-a3ed-7d3f54627384', url: 'https://github.com/demiantradel/gctools_hackathon_2017.git'
  }

  withEnv([
    //"COMPOSE_FILE=docker-compose-test-local.yml"
  ]) {

    stage("Unit") {
      //sh "docker-compose run --rm unit"
      //sh "docker-compose build app"
    }

    stage("Run baseline security scanner") {
      //git clone https://github.com/docker/docker-bench-security.git
      //cd docker-bench-security
    //sh docker-bench-security.sh
    }

    stage("Staging") {
      try {
        sh "docker-compose up"
        //sh "docker-compose up -d staging-dep"
        //sh "docker-compose run --rm staging"
      } catch(e) {
        error "Staging failed"
      } finally {
        sh "docker-compose down"
      }
    }

    stage("Publish") {
      sh "docker tag go-demo \
        localhost:5000/hello-world:2.${env.BUILD_NUMBER}"
      sh "docker push \
        localhost:5000/hello-world:2.${env.BUILD_NUMBER}"
    }

    stage("Prod-like") {
      withEnv([
        "DOCKER_TLS_VERIFY=1",
        "DOCKER_HOST=tcp://${env.PROD_LIKE_IP}:2376",
        "DOCKER_CERT_PATH=/machines/${env.PROD_LIKE_NAME}"
      ]) {
        sh "docker service update \
          --image localhost:5000/hello-world:2.${env.BUILD_NUMBER} \
          hello-world"
      }
      withEnv(["HOST_IP=localhost"]) {
        for (i = 0; i <10; i++) {
          //sh "docker-compose run --rm production"
          // todo run web application security scanner
        }
      }
    }

    stage("Broadcast to OMIS. Send assets, frameworks, version numbers, etc.") {
    }

    stage("Production") {
      withEnv([
        "DOCKER_TLS_VERIFY=1",
        "DOCKER_HOST=tcp://${env.PROD_IP}:2376",
        "DOCKER_CERT_PATH=/machines/${env.PROD_NAME}"
      ]) {
        sh "docker service update \
          --image localhost:5000/hello-world:2.${env.BUILD_NUMBER} \
          hello-world"
      }
      withEnv(["HOST_IP=${env.PROD_IP}"]) {
        for (i = 0; i <10; i++) {
          //sh "docker-compose run --rm production"
        }
      }

    }
  }
}
