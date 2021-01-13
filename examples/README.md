# Edge server

**Run:**

```
docker run --name edge --network=ffplayout-network --mount type=tmpfs,destination=/var/cache/nginx/srs_cache_temp,tmpfs-size=1610612736 -v /opt/ffplayout-docker/examples/edge.conf:/etc/nginx/conf.d/default.conf -p 8082:80 -d nginx:stable-alpine
```

This command uses a ramdisk for the caching folder. When you don't want this, remove the *mount*.

When the edge server runs on a different host, you have to edit **edge.conf** with correct `proxy_pass http://ffplayout-frontend;` and you can remove the `--network=*` parameter.

# TV/Event Switcher

You can use **tv-event.conf** for srs to get the possibility to switch between playout and live stream.
