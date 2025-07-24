# DenKettle Minecraft server

Private minecraft server "denkettle" configuration.

![icon](image/server-icon.png)

## .env file

```shell
cat <<EOF > .env
PASSWD=hoge
LOCAL_DNS=hogehoge
SERVER_HOST_NAME=huga
CONTAINER_NAME=hoge
VERSION=latest
EOF
```

- Run `source` command.

  ```shell
  source .env
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