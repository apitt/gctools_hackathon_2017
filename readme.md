# Team Communications
* Please sign up for slack and join our channel - https://gctoolsteampipeline.slack.com

# Base Install
These instructions set up a dockerized develpment, staging, pre-prod and prod enviroments. This code sets up the CI/CD workflow.

* If required: Install [Docker](https://www.docker.com/get-docker). If using any version Windows please install the [Docker Toolbox](https://www.docker.com/products/docker-toolbox). 
* Install [git](https://git-scm.com/downloads).
* Create a folder under your c:/Users/ and clone the repo - `git clone https://github.com/demiantradel/gctools_hackathon_2017.git` .
* (optional) If you want a clean install to start again:
    * removed the ./docker folder in the gcpedia folder, or 
    * run the `99_shut_down_all.sh` script 
    * reboot your computer
    * delete the .ssh, .docker, .docker\machine\machines, .VirtualBox folders inside the Users folder. 
    * other
* Run `bash docker_scripts/0_install_gcpedia.sh`
* Run `bash docker_scripts/1_create_prod_swarm.sh` 
* Run `bash docker_scripts/2_create_test_swarm.sh` 
* Run `bash docker_scripts/3_make_proxy_and_networks.sh`
* Run `bash docker_scripts/4_create_jenkins.sh`
    * Copy down the temporary jenkins administrative password `cat docker/jenkins/secrets/initialAdminPassword` 
    * Copy down the new suggested password.
    * Run the jenkins set up by running the following inside your docker terminal shell. `start chrome.exe $(docker-machine ip swarm-1):8082/jenkins`
    * Set up jenkins using the following instructions.
        * Use the following credentials for the admin  admin:<THEN_THE_NEW_SUGGESTED_PASSWORD>
        * Install default suggested plugins when asked.
        * Install the Self-organizing swarm plug-in modules. There is no need to restart. `start chrome.exe $(docker-machine ip swarm-1):8082/jenkins/pluginManager/available`

        * Manually copy and paste the comands inside the following script: `docker_scripts/5.manual_creat_jenkins_agent.sh`
        * Load jenkins. And add the following evnriomental variables 
            * `start chrome.exe $(docker-machine ip swarm-1):8082/jenkins/configure`
            * Add the output of `docker-machine ip swarm-1` to PROD_IP
            * Add `swarm-1` to PROD_NAME
            * Add the output of `docker-machine ip swarm-test-1` to PROD_LIKE_IP
            * Add `swarm-test-1` to PROD_LIKE_NAME
        * Load up the jenkins credentials page and enter your github credentials there. `start chrome.exe $(docker-machine ip swarm-1):8082/jenkins/credentials/store/system/newDomain`
            * Set the domain to `github.com` and press ok. Then find the `adding some credentials` link and add your username + password combo.
        * Create a new jenkins job
            * Select 'create a new job' at `start chrome.exe $(docker-machine ip swarm-1):8082/jenkins/newJob`
            * Enter item name as "gcpedia-demo", select Pipeline and then OK.
            * Paste the content of the /jenkins/jenkinsfile.groovy file into the Pipeline script textarea. 
            * (removed step while a public repo)Paste your credential ID from your github credentials into the pull stage of the Pipeline script and press Save.
            * Select `Build Now`            

# Developing
Enter information here on how to develop inside this type of setup. 

# Hardening
List here continuous improvement/monitoring security health checks procedures.
* Maintaining least priviledge
* Maintaining full patched systems

# FAQ
## How do I release code into production?
In a CI/CD when you change code inside the code repository it triggers a full range of automated tasks. If all those tasks pass then the code is released into production.

# How do I shutdown the system?

# How do I back up the system?

# How do I run this code inside a SSC Data Center?
