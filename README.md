# DenKettle Minecraft server

Private minecraft server "denkettle" configuration.

## .env file

```shell
cat <<EOF > .env
PASSWD=<Your password>
LOCAL_DNS=<DNS server IP>
SERVER_HOST_NAME=<Server host name>
CONTAINER_NAME=<Minecraft container name>
VERSION=<Version Number>
EOF
```

```shell
source .env
```

## Commands

- Docker compose up

  ```shell
  docker compose up -d
  ```

## RCON Commands

- Run Docker commands

  ```shell
  docker exec -i $CONTAINER_NAME rcon-cli
  ```

- RCON commands
  - give

    ```shell
    give <target> <item> [<count>]
    ```
  
  - xp

    ```shell
    xp add <target> <num> points
    ```
  
  - enchant

    ```shell
    enchant <target> <enchant name> [<count>]
    ```

    - unbreaking, mending

## Plugin Server

- `minecraft-denkettle/minecraft/data/config/paper-global.yml`

```yaml
~~~
unsupported-settings:
  allow-headless-pistons: false
  allow-permanent-block-break-exploits: false
  allow-piston-duplication: true # <- change here
  allow-unsafe-end-portal-teleportation: false
  compression-format: ZLIB
  perform-username-validation: true
  skip-tripwire-hook-placement-validation: false
  skip-vanilla-damage-tick-when-shield-blocked: false
  update-equipment-on-player-actions: true
~~~
```