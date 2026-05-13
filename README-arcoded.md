## Installation guide

https://openartcoded.github.io/doc/installation/compiled.html

## Misc

### Exporting realm

- uncomment volumes in docker-compose dev
  ```
      # - ./config/keycloak-dev/export:/tmp/export
  ```
- run the command:

      ```
      docker exec -it app-docker_keycloak_1 /opt/keycloak/bin/kc.sh export \
      --file /tmp/export/artcoded-realm.json \
      --realm Artcoded \
      --users same_file
      ```

  > On windows you should use "-" instead of "\_" & you can't use "\" apparently, e.g :

  ```
     docker exec -it app-docker-keycloak-1 /opt/keycloak/bin/kc.sh export --file /tmp/export/artcoded-realm.json  --realm Artcoded --users single_file
  ```

### Importing realm

- move the exported realm to `config/keycloak-dev/import`

- run the command:

  ```
  docker exec -it app-docker_keycloak_1 /opt/keycloak/bin/kc.sh import \
  --file /tmp/import/artcoded-realm.json
  ```

> On windows you should use "-" instead of "\_" & you can't use "\" apparently, e.g :

       docker exec -it app-docker-keycloak-1 /opt/keycloak/bin/kc.sh import  --file /tmp/import/artcoded-realm.json

- restart the stack
  ```
  docker-compose restart
  ```

#### mount volume docker

udisksctl mount -b /dev/sda1

#### list volumes

lsblk -o NAME,FSTYPE,LABEL,SIZE,MOUNTPOINT

#### disable docker

sudo systemctl disable docker.service docker.socket

### troubleshoots

- Keycloak doesn't start because of adminTheme not set:

```
drc exec  postgresql psql --username=keycloak -c "UPDATE REALM SET ADMIN_THEME='keycloak' WHERE ADMIN_THEME IS NULL;";
```

### postgres - add new user

```
docker-compose exec  postgresql psql --username=keycloak -c "CREATE USER nextcloud WITH PASSWORD 'nextcloud';" \
    -c "CREATE DATABASE nextcloud;" \
    -c "GRANT ALL PRIVILEGES ON DATABASE nextcloud TO nextcloud;"
```

### external storage sftp nextcloud

```
docker-compose exec cloud docker-php-ext-install ftp
docker-compose exec cloud docker-php-ext-enable ftp
docker-compose exec cloud apk add --update bzip2-dev
docker-compose exec cloud docker-php-ext-install bz2
docker-compose restart cloud
docker-compose exec --user www-data cloud php occ config:system:set default_phone_region --value="BE"
docker-compose exec cloud sed -i "s/opcache.interned_strings_buffer=8/opcache.interned_strings_buffer=16/g" /usr/local/etc/php/conf.d/opcache-recommended.ini |grep opcache.interned_strings_buffer /usr/local/etc/php/conf.d/opcache-recommended.ini

```
# artcoded-solution
