# ffplayout-docker

Complete playout solution with [engine](https://github.com/ffplayout/ffplayout-engine), [API](https://github.com/ffplayout/ffplayout-api), [Web GUI](https://github.com/ffplayout/ffplayout-frontend) and [srs rtmp/hls server](https://github.com/ossrs/srs).


For using it edit for local paths in **docker-compose.yml** under *volumes* and run:

```
docker-compose up -d
```

Or under fedora 32:

```
podman-compose up -d
```

In **config** folder you found all config files you need, for the engine, srs and nginx (runs in ffplayout-frontend).

Please use always the newest **ffplayout.yml** from [engine](https://github.com/ffplayout/ffplayout-engine), when you build everything new!
