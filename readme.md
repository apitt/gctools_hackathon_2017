# First Install
* If you want a cleaner install please removed the /docker folder, run the `99_shut_down_all.sh` script and reboot your computer.
* Run `bash docker_scripts/1_create_prod_swarm.sh` 
* Run `bash docker_scripts/2_create_jenkins.sh` 
* Run `bash docker_scripts/3_make_proxy_and_networks.sh`
* Run `bash docker_scripts/4_create_jenkins.sh`
* Copy down the temporary jenkins administrative password `cat docker/jenkins/secrets/initialAdminPassword` 
* Copy down the new suggested password.
* Run the jenkins set up by running the following inside your docker terminal shell. `start chrome.exe $(docker-machine ip swarm-1):8082/jenkins`
* todo: Set up jenkins using the following instructions.
    * Use the following credentials for the admin  admin:<THEN_THE_NEW_SUGGESTED_PASSWORD>
    * Install default suggested plugins when asked.
    * Install without restart the Self-organizing swarm plug-in modules `start chrome.exe $(docker-machine ip swarm-1):8082/jenkins/pluginManager/available`

* Manually copy and paste the commands in the following script `bash docker_scripts/5.manual_creat_jenkins_agent.sh`
* Load jenkins. And add the following evnriomental variables 
    * `start chrome.exe $(docker-machine ip swarm-1):8082/jenkins/configure`
    * Add the output of `docker-machine ip swarm-1` to PROD_IP
    * Add `swarm-1` to PROD_NAME
    * Add the output of `docker-machine ip swarm-test-1` to PROD_LIKE_IP
    * Add `swarm-test-1` to PROD_LIKE_NAME
* Place your credentials in the credentials store and get a credentialID
   * `start chrome.exe $(docker-machine ip swarm-1):8082/jenkins/credentials/`
       * Set the domain to `gitlab.ssc.etg.gc.ca`, and your username + password combo.
   * Get your credential ID and place it inside the pull stage of the Fenkinsfile.

# Developing
# Hardening
## The setup profile vs the run profile
# Maintaining
# Shutting it Down