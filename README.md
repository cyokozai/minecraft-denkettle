# DenKettle Minecraft server

Private minecraft server "denkettle" configuration.

![icon](image/server-icon.png)

## .env file

- Set environment variables.

  ```shell
  cat <<EOF > .env
  VERSION=latest
  EULA=TRUE
  ENABLE_ROLLING_LOGS=TRUE
  TYPE=PAPER
  DIFFICULTY=hard
  LEVEL=world
  MOTD=✋(◉ ω ◉｀)よお
  MAX_PLAYERS=30
  MAX_WORLD_SIZE=12000
  ENABLE_RCON=TRUE
  ENABLE_COMMAND_BLOCK=TRUE
  FORCE_WORLD_COPY=TRUE
  SNOOPER_ENABLED=FALSE
  VIEW_DISTANCE=50
  SIMULATION_DISTANCE=100
  GAMEMODE=survival
  PVP=TRUE
  ANNOUNCE_PLAYER_ACHIEVEMENTS=TRUE
  OVERRIDE_ICON=TRUE
  ENABLE_WHITELIST=TRUE
  MAX_THREADS=6
  INIT_MEMORY=8G
  MAX_MEMORY=16G
  SERVER_PORT=25565
  JVM_OPTS=-XX:MaxRAMPercentage=95 -Xms8192M -Xmx16384M -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:MaxInlineLevel=15
  PAPER_CHANNEL=experimental
  EOF
  ```

- Set secret variables.

  ```shell
  cat <<EOF > secret.env
  CONTAINER_NAME=hoge
  LOCAL_DNS=hogehoge
  SERVER_HOST_NAME=huga
  RCON_PASSWORD=hoge
  EOF
  ```

### Make a ConfigMap and Secret

- Run the following command.

  ```shell
  sudo chmod +x gensecret.sh
  ```

- Create a ConfigMap.

  ```shell
  ./gensecret.sh .env ConfigMap
  ConfigMap created in manifests/k8s-configmap.yaml
  ```

- Create a Secret.

  ```shell
  ./gensecret.sh secret.env Secret
  Secret created in manifests/k8s-secret.yaml
  ```

## Commands

### Docker

- Run Docker container.

  ```shell
  docker compose up -d
  ```

- Stop  docker compose down

  ```shell
  docker compose down
  ```

### Kubernetes 

  ```shell
  kubectl apply -f manifests
  ```

  ```shell
  kubectl exec -it $CONTAINER_NAME -- /bin/bash
  ```

### RCON Commands

- Docker exec

  ```shell
  docker exec -i $CONTAINER_NAME rcon-cli
  ```

- Kubectl exec

  ```shell
  kubectl exec -it $CONTAINER_NAME rcon-cli
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

    - unbreaking
    - mending

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
