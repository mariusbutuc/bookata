# 03. Building your own Docker images

Software distribution is built into the Docker platform.

- One image is made up of one or more image layers.
- Image servers are called _registries_.

## Environment variables

- Key/value pairs that the operating system provides.
- A very simple way to store small pieces of data.
- Docker images may be packed with a default set of configuration values for the application

  - but one should be able to provide different configuration settings when running a container:

    ```sh
    docker container run \
      --env TARGET=google.com \
      diamol/ch03-web-ping
    ```

  - Same application <> same set of binaries
  - Different behaviour <> different configuration
  - It's up to the author of the Docker image to provide that **flexibility**.

## Writing the first Dockerfile

The Dockerfile is a simple script: it's a set of instructions, and a Docker image is the output.

```ex
docker_image =
  instructions
  |> Dockerfile.run()
```

### Dockerfile instructions

- `FROM` - Every image has to start from another image… _How is the first image created then?_
- `ENV` - Set values for environment variables.
- `WORKDIR` - Set the working directory for any subsequent `ADD`, `COPY`, `CMD`, `ENTRYPOINT`, or `RUN` instructions that follow it in the Dockerfile.
- `COPY` - Copy files or directories from the local filesystem into the container image.
- `CMD` - Specifies the command to run when Docker starts a container from the image.

## Building the container image from the Dockerfile

```sh
docker image build \
  --tag web-ping \    # the name for the image
  .                   # the "context" directory

[+] Building 0.5s (8/8) FINISHED
 => [internal] load build definition from Dockerfile                                                  0.1s
 => => transferring dockerfile: 196B                                                                  0.0s
 => [internal] load .dockerignore                                                                     0.0s
 => => transferring context: 2B                                                                       0.0s
 => [internal] load metadata for docker.io/diamol/node:latest                                         0.0s
 => [1/3] FROM docker.io/diamol/node                                                                  0.1s
 => [internal] load build context                                                                     0.1s
 => => transferring context: 930B                                                                     0.0s
 => [2/3] WORKDIR /web-ping                                                                           0.0s
 => [3/3] COPY app.js .                                                                               0.1s
 => exporting to image                                                                                0.1s
 => => exporting layers                                                                               0.1s
 => => writing image sha256:f11793c79ed8bbeb33f0ba9836c401bc69b2a5a33d17c97513a2540904837348          0.0s
 => => naming to docker.io/library/web-ping                                                           /2.2s
```

## Packing an application

Either a simple application or a complicated one, the process is exactly the same:

1. Write a Dockerfile: all the steps to package the app.
1. Collect the resources that need to go into the Docker image.
1. Decide how we want the users of the image to configure the behaviour of the app.

## Understanding Docker images and image layers

- The relationship between images and containers.

The docker image contains:

- All the files that are packaged => the container's filesystem.
- A lot of metadata

  ```sh
  docker image history web-ping
  ```

### Image layers

- There is a 1-to-1 relationship between each instruction/line in the Dockerfile and an image layer.
- Understanding image layers is 🔑 key to making the **most efficient** use of Docker.
  - A Docker _image_ is a **logical** collection of image layers.
  - The _image layers_
    - Are the files that are "**physical**ly" stored in the Docker Engine's cache.
    - Can be **shared** between images and containers.
      - Saving on disk space.
    - If image layers are shared around, they _can't be edited_.
      - A change in one image cascades to all other images that share the changed layer.
      - Docker enforces this by making image layers _read-only_.

```sh
docker image history web-ping
docker image ls
docker system df
```

Optimize Dockerfiles

- Smaller Docker images
- Faster builds

## Optimizing Dockerfiles to use the image layer cache

```sh
docker image build \
  --tag web-ping:v2 \
  .

[+] Building 0.3s (8/8) FINISHED
 => [internal] load build definition from Dockerfile                                                  0.0s
 => => transferring dockerfile: 196B                                                                  0.0s
 => [internal] load .dockerignore                                                                     0.0s
 => => transferring context: 2B                                                                       0.0s
 => [internal] load metadata for docker.io/diamol/node:latest                                         0.0s
 => [internal] load build context                                                                     0.0s
 => => transferring context: 932B                                                                     0.0s
 => [1/3] FROM docker.io/diamol/node                                                                  0.0s
 => CACHED [2/3] WORKDIR /web-ping                                                                    0.0s
 => [3/3] COPY app.js .                                                                               0.0s
 => exporting to image                                                                                0.0s
 => => exporting layers                                                                               0.0s
 => => writing image sha256:3227695266da79e5b3e1919eec962e0d3f0333c6b3dc379c2aad638e8e6e12db          0.0s
 => => naming to docker.io/library/web-ping:v2                                                        /1.5s
```

Every Dockerfile instruction results in an image layer.

- Docker uses previous cache if

  - The instruction doesn't change between builds _and_
  - The input to the instruction is the same.

- As soon as the cache is broken, all the instructions that follow are executed.

### Dockerfile oprimization: Tip 1

Order the instructions by how often they change:

- Unlikely to change? Move to the top of the file.
- Most likely to change? Move at the end.
- Goal:
  - Most builds should **only** need to **execute the last instruction**.
  - Use the cache for everything else.

```sh
docker image build -t web-ping:v3 .
[+] Building 0.2s (8/8) FINISHED
 => [internal] load build definition from Dockerfile                                                  0.1s
 => => transferring dockerfile: 376B                                                                  0.0s
 => [internal] load .dockerignore                                                                     0.0s
 => => transferring context: 2B                                                                       0.0s
 => [internal] load metadata for docker.io/diamol/node:latest                                         0.0s
 => [internal] load build context                                                                     0.0s
 => => transferring context: 28B                                                                      0.0s
 => [1/3] FROM docker.io/diamol/node                                                                  0.0s
 => CACHED [2/3] WORKDIR /web-ping                                                                    0.0s
 => CACHED [3/3] COPY app.js .                                                                        0.0s
 => exporting to image                                                                                0.0s
 => => exporting layers                                                                               0.0s
 => => writing image sha256:cd00ec46bb90c751ae68942b9afcd1a779e28c260b0bdb375956a62ac565c9a2          0.0s
 => => naming to docker.io/library/web-ping:v3                                                        /1.4s
```

### Dockerfile oprimization: Tip 2

Ensure that the application can read configuration values from the container.

- **Faster build** times.
- Deploy to Prod using **the exact same image** that passed QA in the Test environments.

## Lab #2: How do we produce a Docker image without a Dockerfile?

- The Dockerfile is there to automate the deployment of our app.
- What if there is a step that cannot be automated/scripted? What if some steps need to be finished off manually?

### Task

1. Start with an image from Docker Hub: `diamol/ch03-lab`.

   - The image contains a file at the path `/diamol/ch03.txt`.

1. Update the text file to add my name at the end.

1. Produce a new image with the changed file.

   - All without using a `Dockerfile`.

### Hints

- Remember the `-it` flags.
- The filesystem for a container still exists when it is exited.
- `docker container --help` —there are two commands that could help solve this lab.  
  Perhaps:

  - `docker container commit` - _Create a new image from a container's changes_
  - `docker container exec` - _Run a command in a running container_

### My [solution]

```sh
CONTAINER_NAME="03_lab"
NAME="Marius"
TEXT_FILE_PATH="/diamol/ch03.txt"

# 1. Start with an image from Docker Hub: `diamol/ch03-lab`.
docker container run \
  --detach \
  --name $CONTAINER_NAME \
  diamol/ch03-lab

# 2. Update the text file to add my name at the end.
docker container exec \
  -it \
  --env NAME=$NAME \
  --env TEXT_FILE_PATH=$TEXT_FILE_PATH \
  $CONTAINER_NAME sh

echo $NAME >> $TEXT_FILE_PATH

# 3. Produce a new image with the changed file.
docker container commit \
  --author "Marius Butuc <contact@mariusbutuc.com>" \
  $CONTAINER_NAME \
  $CONTAINER_NAME
```

[solution]: 03_lab.sh
