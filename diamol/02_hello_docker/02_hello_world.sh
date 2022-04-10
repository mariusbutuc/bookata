set -x

# Running Hello World in a Container
# docker container run diamol/ch02-hello-diamol # Size: 5.55MB

# Connecting to a container like a remote computer
# docker container run --interactive --tty diamol/base # Size: 7.15MB

# CONTAINER_ID=$(docker ps --filter ancestor=diamol/base --format "{{.ID}}")

## List the processes running on the container
# docker container top $CONTAINER_ID

## Display any log entries the container has collected
# docker container logs $CONTAINER_ID

## Show all the details of the container
# docker container inspect $CONTAINER_ID

### Hosting a website in a container

## Show all containers, in any status (even exited ones—no longer use CPU and memory, but do take up space on disk)
# docker container ls --all

docker container run --detach --publish 8088:80 diamol/ch02-hello-diamol-web # Size: 55.5MB

docker container stats

docker container rm --force $(docker container ls --all --quiet)
