docker-machine rm -f swarm-1 swarm-2 swarm-3 swarm-test-1 swarm-test-2 swarm-test-3 

## The following two commands are great at putting your swarm down, and the rebooting it with the same IP addresses later. 
# docker-machine start swarm-1 swarm-2 swarm-3 swarm-test-1 swarm-test-2 swarm-test-3 
# docker-machine stop swarm-1 swarm-2 swarm-3 swarm-test-1 swarm-test-2 swarm-test-3 