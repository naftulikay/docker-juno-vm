# docker-juno-vm [![Build Status][travis.svg]][travis] [![Docker Build][docker.svg]][docker]

A lightweight elementary OS 5.0 Juno VM in Docker, primarily used for integration testing of Ansible roles.

## Usage

The image and container can be built and started like so:

```
$ docker build -it naftulkay/juno-vm:latest ./
$ docker run -d --name juno -v /sys/fs/cgroup:/sys/fs/cgroup:ro --privileged \
      naftulikay/juno-vm:latest
$ docker exec -it juno wait-for-boot
```

View [`docker-compose.yml`](./docker-compose.yml) for a working reference on how to build and run the image/container.

## License

Licensed at your discretion under either:

 - [MIT License](./LICENSE-MIT)
 - [Apache License, Version 2.0](./LICENSE-APACHE)

 [docker]: https://hub.docker.com/r/naftulikay/juno-vm/
 [docker.svg]: https://img.shields.io/docker/automated/naftulikay/juno-vm.svg
 [travis]: https://travis-ci.org/naftulikay/docker-juno-vm/
 [travis.svg]: https://travis-ci.org/naftulikay/docker-juno-vm.svg?branch=master
