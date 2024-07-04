# 2. Understanding Docker and running Hello World

## Build, share, run

1. Build: package the app.
1. Share: publish it.
1. Run: the app in a container.

## Some 🔑 key benefits

- **Portability**: run even on a Raspberry Pi!.
- **Efficiency**: density + isolation.

- Have a process. It relies on:

  - a whole set of scripts _(to automate)_
  - a specific set of tools _(to run the scripts)_
  - a document _(to describe the tool setup)_
  - time _(hours?)_ spent _(for the colleague to install)_

- Alternatively, in pseudo-code, of course:

  ```ex
  [
    [tools],
    [scripts]
  ]
  |> Docker.package_image()
  ```

## Commands to manage containers

- `--help`: ☺️
- `run`: _Run a command in a new container_
  - `--detach` / `-d`: _Detached mode: leave the container running in the background_
  - `--interactive` / `-i`: _Keep stdin open even if not attached_
  - `--name <string>`: _Assign a name to the container_
  - `--publish` / `-p`: _Publish a container's port(s) to the host_
  - `--rm`: _Automatically remove the container when it exits_
  - `--tty` / `-t`: to connect to a terminal session inside the container / _Allocate a pseudo-tty_
- `ls`: _List containers_
  - `--size` / `-s`: _Display total file sizes_
- `top`: _Display the running processes of a container_
- `logs`: to read out the logs / _Fetch the logs of a container_
  - `--follow` / `-f`: _Follow log output_
- `inspect`: to get the details (the paths of the container's virtual file system, the command running inside the container, the virtual Docker network the container is connected to, etc.)
- `stats`: _Display a live stream of container(s) resource usage statistics_

## The main usecase for Docker:

Run containers in background

- server applications—websites
- batch processes
- databases

## Lab #1: Exploring the container filesystem

### Task

Run the website container from this chapter, but replace the `index.html` file.

### My [solution]

```sh
docker container run \
 --detach \
 --name sweet_feynman \
 --publish 8088:80 \
 --rm \
 diamol/ch02-hello-diamol-web

```

```sh
docker container exec \
  --interactive \
  --tty \
  --workdir /usr/local/apache2/htdocs \
  sweet_feynman sh
```

```sh
vi index.html
```

[solution]: 02_lab.sh
