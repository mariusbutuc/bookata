# Lab #2: How do we produce a Docker image without a Dockerfile?

set -x

# Task
#   1. Start with an image from Docker Hub: `diamol/ch03-lab`.
#   2. The image contains a file at the path `/diamol/ch03.txt`.
#   3. Update the text file to add my name at the end.
#   4. Produce a new image with the changed file.
#   5. All without using a `Dockerfile`.

CONTAINER_NAME="03_lab"
NAME="Marius"
TEXT_FILE_PATH="/diamol/ch03.txt"

docker container run \
  -it \
  --detach \
  --name $CONTAINER_NAME \
  diamol/ch03-lab

# docker container exec \
#   $CONTAINER_NAME \
#   cat $TEXT_FILE_PATH
# > Lab solution, by: %

docker container exec \
  -it \
  --env NAME=$NAME \
  --env TEXT_FILE_PATH=$TEXT_FILE_PATH \
  $CONTAINER_NAME sh
# echo $NAME >> $TEXT_FILE_PATH

# docker container exec \
#   $CONTAINER_NAME \
#   cat $TEXT_FILE_PATH
# > Lab solution, by: Marius

# docker container commit - Create a new image from a container's changes
docker container commit \
  --author "Marius Butuc <contact@mariusbutuc.com>" \
  $CONTAINER_NAME \
  $CONTAINER_NAME

docker image ls $CONTAINER_NAME
docker image history $CONTAINER_NAME
# IMAGE          CREATED          CREATED BY    SIZE      COMMENT
# 9880f50ff8a7   30 seconds ago   /bin/sh       117B
# …
