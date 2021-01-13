# ffplayout-docker

Complete playout solution with [engine](https://github.com/ffplayout/ffplayout-engine), [API](https://github.com/ffplayout/ffplayout-api), [Web GUI](https://github.com/ffplayout/ffplayout-frontend) and [srs rtmp/hls server](https://github.com/ossrs/srs).

A debian like host system, with a recent docker version, is recommend.

## How To
- use offical version from [docker.com](https://docs.docker.com/engine/install/debian/)
- get latest [docker-compose](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-debian-10)
- cd in to **/opt/**
- clone repo and cd into it
- run `docker-compose up -d`

Default login is:
- user: **admin**
- pass: **admin**

The GUI can be reach over **http://[host ip]:8088**, but you should use a http(s) proxy.
