# 4. Packaging applications from source code into Docker Images

## `Dockerfile`

- Chapter 3: _instructions_
- Chapter 4: we can run _commands_ inside
- _Instructions_ vs _commands_: what is the difference?
  - Commands execute during the build.
    - Any filesystem changes are saved in the image layer.

## `Dockerfile` vs the build server/service

### The build server/service

- It keeps the project healthy.
- It comes with a maintenance overhead / cost.
  - The _time_ taken for the new team member to install the build tools.
  - Updating a tool locally, while the build server is running a different version, can _fail the build_.
  - _Limited options_ for the tools supported on the managed build service.

### Multi-stage `Dockerfile`s

```docker
FROM diamol/base AS build-stage
RUN echo 'Building…' > /build.txt

FROM diamol/base AS test-stage
COPY --from=build-stage /build.txt /build.txt
RUN echo 'Testing…' >> /build.txt

FROM diamol/base
COPY --from=test-stage /build.txt /build.txt
CMD cat /build.txt
```

- `FROM baseImage AS stage` - give this build stage a name.
- `COPY --from=build-stage …` - copy from an earlier stage in the Dockerfile, rather than from the filesystem of the host computer.
- `RUN …` — this instruction executes a command inside the container during the build. Any output is saved in the image layer.

```sh
➜ docker image build -t multi-stage .
[+] Building 8.0s (9/9) FINISHED
 => [internal] load build definition from Dockerfile                                 0.2s
 => => transferring dockerfile: 308B                                                 0.0s
 => [internal] load .dockerignore                                                    0.2s
 => => transferring context: 2B                                                      0.0s
 => [internal] load metadata for docker.io/diamol/base:latest                        0.0s
 => [stage-2 1/2] FROM docker.io/diamol/base                                         0.1s
 => [build-stage 2/2] RUN echo 'Building…' > /build.txt                              5.9s
 => [test-stage 2/3] COPY --from=build-stage /build.txt /build.txt                   0.3s
 => [test-stage 3/3] RUN echo 'Testing…' >> /build.txt                               0.7s
 => [stage-2 2/2] COPY --from=test-stage /build.txt /build.txt                       0.1s
 => exporting to image                                                               0.1s
 => => exporting layers                                                              0.1s
 => => writing image sha256:fd086e014eab85b3ebd60536ed6d6c425f18082afbb39180eef8e89  0.0s
 => => naming to docker.io/library/multi-stage                                      /10.3s
```

### Benefits

1. True Portability: We can run the app anywhere and we can build the app anywhere: Docker is the only prerequisite.
1. Using the public images of any of the major frameworks:
   - Benefit from using all the latest updates.
   - The images are maintained by the project teams.

## Running a distributed application across three containers

### The Docker network

- Create & manage a virtual Docker network for containers to communicate over

  ```sh
  docker network create nat
  ```

- Explicitly connect a container to this specific Docker network using the `--network` flag

### The Java REST API app: _build_ and _run_ the app

- A [simple REST API](./image-of-the-day/)

  - Wrap access to [NASA’s Astronomy Picture of the Day service](https://apod.nasa.gov)
  - Fetch today's picture details.
  - Cache it, so repeated calls to this application will not repeteadly hit NASA's service.

- To **build** the app, the host does _not_ need to have/manage

  - Any build tools. Also, no build tools installed on the (final) application image.
  - A specific version of Java.

    ```sh
    docker image build -t image-of-the-day ./image-of-the-day
    ```

- To **run** the app, just

  - Have Docker installed.
  - Clone the repo.
  - Run a couple of Docker commands.

    ```sh
    docker container run \
      --name iotd \
      -d \
      -p 800:80 \
      --network nat \
      image-of-the-day
    ```

- http://localhost:800/image

- This pattern works for other **compiled** languages like _.NET Core_ and _Erlang_.

### The Node.js REST API app

- Another [simple REST API](./access-log/)

  - Other services can call to write logs.
  - Exposes an HTTP `POST` endpoint to record a new log
  - Exposes an HTTP `GET` endpoint to show how many logs have been recorded.

- Dockerized Node.js apps **build** an application image with

  - The Node.js runtime.
  - The source code.

- In this pattern there is no compilation step. It works for other **interpreted** languages like _Ruby_, _Python_, and _PHP_.

- Different techology stack with a different pattern for packaging the app.

  - All the differences are captured in the Dockerfile.
  - The process of _building_ and _running_ the app is exactly the same.

    ```sh
    docker image build -t access-log ./access-log

    docker container run \
      --name accesslog \
      -d \
      -p 801:80 \
      --network nat \
      access-log
    ```

- **Doubt:** On page 55 of the paper book, it is said about the benefits of using a multi-stage (build / run) Dockerfile even for an interpreted language that:

  > […] if you work on the app and just make code changes, the next build you run will be super fast.

  - **Q:** Wait, but… don't we already get this benefit from placing the `COPY src/ .` instruction last in the Dockerfile?

  - **My own A:** Yes and no… because each stage has its own cache (second point—_performance_—in section 4.5/page 59).

    - For example, let's imagine that:

      - The _builder_ stage gets a different dependency form `package.json`
      - The _app_'s now breaks only starting with the second-last instruction (`COPY --from=builder […]`),
        - while the previous four image layers are still fetched from cache
      - Otherwise, if this were a single-stage Dockerfile instead of a multi-stage one, the entire cache would be broken starting from the `COPY src/package.json .` instruction in the _builder_ stage. **Correct?**

- http://localhost:801/stats

### The Go web application

- A [web application written in Go](./image-gallery/):

  - Call the Java API to get details about the image to show.
  - Call the Node.js API to log that the site has been accessed.

- Go compiles to _native binaries_.

  - The compiled output is the complete application.
  - No separate runtime needs to be installed.
  - Makes for _extremely_ small Docker images.
    - The Go application image size (~27 MB) is much, much smaller compared to the Go toolset image (~800 MB).
    - Though part of this image size might be virtual, it's all the software that **isn't** in the final image that is important.
      - This is a huge reduction in the surface area for potential attacks.
  - Pattern applicable to _Rust_ and _Swift_ as well.

- http://localhost:802/

## Top benefits of using multi-stage Dockerfiles

1. Standardization:

   - Everyone has the exact same tools, at all the correct versions.
   - Simplify on-boarding.
   - Eliminate maintenance overhead for build servers.

1. Performance:

   - Maximize (+90%) the steps that are using the cache.

1. Lean application image:

   - Faster startup times.
   - Fewer potential exploits for attackers.
