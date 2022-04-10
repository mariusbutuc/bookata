set -x

# Sample: image from minimal multi-stage Dockerfile
# docker image build -t multi-stage .

# Build the REST API Java app over NASA's Astronomy Picture of the Day service
docker image build -t image-of-the-day ./image-of-the-day

# Create a Docker network for containers to communicate with each other
docker network create nat

# Run a container from the image, publishing port 80 to the host, and connectiong to the `nat` network
docker container run \
  --name iotd \
  -d \
  -p 800:80 \
  --network nat \
  image-of-the-day

# Build and run the Node.js REST API
docker image build -t access-log ./access-log

docker container run \
  --name accesslog \
  -d \
  -p 801:80 \
  --network nat \
  access-log

# Build and run the Go web application
docker image build -t image-gallery ./image-gallery

docker container run \
  -d \
  -p 802:80 \
  --network nat \
  image-gallery
