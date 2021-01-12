# ffplayout-docker

Complete playout solution with [engine](https://github.com/ffplayout/ffplayout-engine), [API](https://github.com/ffplayout/ffplayout-api), [Web GUI](https://github.com/ffplayout/ffplayout-frontend) and [srs rtmp/hls server](https://github.com/ossrs/srs).

**Run:**

```
docker-compose up -d
```

A debian like host system, with a recent docker version, is recommend.

In **config** folder you found all config files you need, for the engine, srs and nginx (runs in ffplayout-frontend).

Default login is:
- user: **admin**
- pass: **admin**

The GUI can be reach over **http://[host ip]:8088**, but you should use a http(s) proxy.

# Info
You should use the offical docker version from [docker.com](https://docs.docker.com/engine/install/debian/) and the latest [docker-compose](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-debian-10)
