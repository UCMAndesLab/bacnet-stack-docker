# Docker Bacnet Server

This is the source for
https://hub.docker.com/r/ucmercedandeslab/bacnet-server/ which is bacnet
server based on the [bacnet-stack](https://github.com/stargieg/bacnet-stack)

When running this server there are a few points that are available. The
config file has each interface that is made available for the interface.

## Installing

To get the lastest from the docker hub:

```sh
docker pull ucmercedandeslab/bacnet-server
```

To build from source:

```sh
docker build . ucmercedandeslab/bacnet-server
```

## Running

To run a daeomon use:

```sh
docker run -d ucmercedandeslab/bacnet-server
```