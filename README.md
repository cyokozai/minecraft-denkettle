# DenKettle Minecraft server

Private minecraft server "denkettle" configuration.

![icon](image/server-icon.png)

## .env file

- Set environment variables.

  ```shell
  cat <<EOF > .env
  CONTAINER_NAME=hoge
  LOCAL_DNS=hogehoge
  SERVER_HOST_NAME=huga
  RCON_PASSWORD=hoge
  VERSION=latest
  EULA=TRUE
  ENABLE_ROLLING_LOGS=TRUE
  TYPE="PAPER"
  DIFFICULTY="hard"
  LEVEL="world"
  MOTD="✋(◉ ω ◉｀)よお"
  MAX_PLAYERS=30
  MAX_WORLD_SIZE=12000
  ENABLE_RCON=TRUE
  ENABLE_COMMAND_BLOCK=TRUE
  FORCE_WORLD_COPY=TRUE
  SNOOPER_ENABLED=FALSE
  VIEW_DISTANCE=50
  SIMULATION_DISTANCE=100
  GAMEMODE="survival"
  PVP=TRUE
  ANNOUNCE_PLAYER_ACHIEVEMENTS=TRUE
  OVERRIDE_ICON=TRUE
  ENABLE_WHITELIST=TRUE
  MAX_THREADS=6
  INIT_MEMORY=8G
  MAX_MEMORY=16G
  SERVER_PORT="25565"
  JVM_OPTS="-XX:MaxRAMPercentage=95 -Xms8192M -Xmx16384M -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:MaxInlineLevel=15"
  PAPER_CHANNEL="experimental"
  EOF
  ```

- Set secret variables.

  ```shell
  cat <<EOF > .env.secret
  CONTAINER_NAME=hoge
  LOCAL_DNS=hogehoge
  SERVER_HOST_NAME=huga
  RCON_PASSWORD=hoge
  EOF
  ```

- Run `source` command.

  ```shell
  source .env
  source .env.secret
  ```

### Make a ConfigMap in Kubernetes

- Run the following command.

```shell
kubectl create configmap minecraft-server-config --from-env-file=.env
```

- Confirm the ConfigMap.

  ```shell
  kubectl get configmap minecraft-server-config
  ```
  
  - Result
  
    ```shell
    NAME                      DATA   AGE
    minecraft-server-config   5      7s
    ```

- If you want to delete the ConfigMap, run the following command.

  ```shell
  kubectl delete configmap minecraft-server-config
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
