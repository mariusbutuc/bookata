# Lab #2: How do we produce a Docker image without a Dockerfile?
#   Sample solution: https://github.com/sixeyed/diamol/tree/master/ch03/lab

set -x

# Task
#   1. Start with an image from Docker Hub: `diamol/ch03-lab`.
#       - The image contains a file at the path `/diamol/ch03.txt`.
#   2. Update the text file to add my name at the end.
#   3. Produce a new image with the changed file.
#       - All without using a `Dockerfile`.

CONTAINER_NAME="03_lab"
IMAGE_NAME=${CONTAINER_NAME}_image
NAME="Marius"
TEXT_FILE_PATH="/diamol/ch03.txt"

# 1. Start with an image from Docker Hub: `diamol/ch03-lab`.
docker container run \
  -it \
  --env NAME=$NAME \
  --env TEXT_FILE_PATH=$TEXT_FILE_PATH \
  --name $CONTAINER_NAME \
  diamol/ch03-lab

# docker container exec \
#   $CONTAINER_NAME \
#   cat $TEXT_FILE_PATH
# > Lab solution, by: %

# 2. Update the text file to add my name at the end.
echo $NAME >> $TEXT_FILE_PATH

# 3. Produce a new image with the changed file.
docker container commit \
  $CONTAINER_NAME \
  $IMAGE_NAME

docker image ls $IMAGE_NAME
docker image history $IMAGE_NAME
# IMAGE          CREATED          CREATED BY    SIZE      COMMENT
# 9880f50ff8a7   30 seconds ago   /bin/sh       117B
# …

docker container run \
  $IMAGE_NAME \
  cat ch03.txt
# > Lab solution, by: Marius
