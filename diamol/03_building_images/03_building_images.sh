set -x

# Pulling an image from Docker Hub [1]
#   [1]: https://hub.docker.com/r/diamol/ch03-web-ping
# docker image pull diamol/ch03-web-ping

## The `--name` flag in this command allows to give containers friendly names
# docker container run \
#   -d \
#   --name web-ping \
#   diamol/ch03-web-ping

# docker container logs web-ping
# docker rm --force web-ping

# Environment variables

## Specify different values for environment variables when creating a container
# docker container run \
#   --rm \
#   --env TARGET=google.com \
#   diamol/ch03-web-ping

# Building the container image from the Dockerfile

docker image build \
  --tag web-ping \    # the name for the image
  .                   # the "context" directory

docker image ls 'w*'

docker container run \
  -e TARGET=docker.com \
  -e INTERVAL=5000 \
  web-ping

docker image history web-ping

docker image ls 'diamol/*'

docker image build \
  -t web-ping:v2 \
  .

docker image build \
  -t web-ping:v3 \
  .
