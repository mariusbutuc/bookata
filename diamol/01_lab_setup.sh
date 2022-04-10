set -x

# Verifying the Docker setup
# docker version
# docker-compose version

# Remember to tidy up
docker container rm -f $(docker container ls -aq)
docker image rm -f $(docker image ls -f reference='diamol/*' -q)
