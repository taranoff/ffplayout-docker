### Run:
-   `docker build --tag ffplayout-api:master .`
-   ```
    docker run --name ffplayout-api -p 8001:8001 \
    --volume /etc/ffplayout/ffplayout.yml:/etc/ffplayout/ffplayout.yml \
    --volume /var/log/logs:/var/log/ffplayout \
    --volume /tv-media:/tv-media \
    --volume /playlists:/playlists \
    -itd ffplayout-api:master
    ```

Default credentials are:
- User: admin
- pass: admin

Change this after build!

On SELinux systems allow write access to **ffplayout.yml**:

```
semanage fcontext -a -t container_file_t '/etc/ffplayout/ffplayout.yml'

restorecon -v '/etc/ffplayout/ffplayout.yml'
```
