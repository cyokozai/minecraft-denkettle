# minecraft-denkettle

Private minecraft server configuration.

## .env file

```shell
cat <<EOF > .env
PASSWD=<Your password>
LOCAL_DNS=<DNS server IP>
SERVER_HOST_NAME=<Server host name>
CONTAINER_NAME=<Minecraft container name>
EOF
```

```shell
source .env
```

## Commands

```shell
docker exec -i $CONTAINER_NAME rcon-cli
```

```shell
give give <target> <item> [<count>]
```
