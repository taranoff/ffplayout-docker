Run origin server:

```
docker run --name origin --mount type=tmpfs,destination=/var/cache/nginx/srs_cache_temp,tmpfs-size=1610612736 -v ./origin.conf:/etc/nginx/nginx.conf -p 8082:80 -d nginx:stable-alpine
```

This command uses a ramdisk for the caching folder. When you don't want this, remove the *mount*.
