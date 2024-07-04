# Exploring the container filesystem
#   Sample solution: https://github.com/sixeyed/diamol/tree/master/ch02/lab

# Task: run the website container from this chapter, but replace the `index.html` file.

set -x

# Hypothesis 1:
## Experiment: Connect to a terminal session inside the diamol/ch02-hello-diamol-web container & edit index.html

# docker container run \
#   --detach \
#   --interactive \
#   --name sweet_feynman \
#   --publish 8088:80 \
#   --tty \
#   diamol/ch02-hello-diamol-web

## Conclusion: `--detach` runs the container in background. Perhaps I need to attach to the console separately?

# Hypothesis 2:
## Experiment: Start the container and attach to the console separately

# docker container stop sweet_feynman
# docker container start \
#   --attach \
#   --interactive \
#   sweet_feynman

## Conclusion: Not really an operational console?

# Hypothesis 3:
## Experiment: Run the container from the beginning in interactive/TTY mode.

# docker container prune
# docker container run \
#   --interactive \
#   --name sweet_feynman \
#   --rm \
#   --tty \
#   diamol/ch02-hello-diamol-web

## Conclusion: Same as before: not a operational console?
##  > AH00094: Command line: 'httpd -D FOREGROUND'
##    Apache is initialized and accepting connections [1]
## [1]: https://github.com/docker-library/php/issues/1004#issuecomment-616625976

# Hypothesis 4:
## Experiment: Run the website container from this chapter + try to access the running container's storage
docker container run \
  --detach \
  --name sweet_feynman \
  --publish 8088:80 \
  --rm \
  diamol/ch02-hello-diamol-web

docker container exec \
  --interactive \
  --tty \
  --workdir /usr/local/apache2/htdocs \
  sweet_feynman sh

# Hypothesis 5:
## Experiment: Learn from the author's approach/Sample solution: https://github.com/sixeyed/diamol/tree/master/ch02/lab
CONTAINER_NAME="sweet_feynman"
CONTENT_DIRECTORY="/usr/local/apache2/htdocs"

# 1. Run the web container from the chapter exercises:
docker container run \
  --detach \
  --name $CONTAINER_NAME \
  --publish 8088:80 \
  diamol/ch02-hello-diamol-web

# 2. [Optional] Check that the HTML page in the container is in the expected location:
docker container exec \
  $CONTAINER_NAME \
  ls $CONTENT_DIRECTORY

# 3. Use `docker container cp` to overwrite the `index.html` file in the container with the one in the current directory
docker container cp \
  index.html \
  $CONTAINER_NAME:${CONTENT_DIRECTORY}/index.html

# Cleanup

# docker container rm --force $(docker container ls --all --quiet)
