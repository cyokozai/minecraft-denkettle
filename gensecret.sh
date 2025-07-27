#!/bin/bash
ENV_FILE="$1"
KIND="$2"
NAMESPACE="default"
FILE_NAME="k8s-$(echo "$KIND" | tr '[:upper:]' '[:lower:]')"

if [[ -z "$ENV_FILE" ]]; then
  echo "No environment file provided."
  echo "Usage: $0 <env_file> <kind>"
  exit 1
fi

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Error: File '$ENV_FILE' does not exist."
  exit 1
fi

if [[ -z "$KIND" ]]; then
  echo "No kind provided. Defaulting to 'Secret'."
  echo "Usage: $0 <env_file> <kind>"
  exit 1
fi

if [[ "$KIND" != "ConfigMap" && "$KIND" != "Secret" ]]; then
  echo "Error: Invalid kind '$KIND'."
  echo "Usage: $0 <env_file> <kind>"
  exit 1
fi

echo "apiVersion: v1
kind: $KIND
metadata:
  name: $FILE_NAME
  namespace: $NAMESPACE
type: Opaque
data:" > manifests/$FILE_NAME.yaml

while IFS='=' read -r key value || [[ -n "$key" ]]; do
  [[ "$key" == \#* || -z "$key" ]] && continue
  if [[ "$KIND" == "ConfigMap" ]]; then
    encoded_value=$(echo -n "$value" | sed 's/"/\\"/g')  # Escape quotes for ConfigMap
  fi
  if [[ "$KIND" == "Secret" ]]; then
    encoded_value=$(echo -n "$value" | base64)  # Encode value for Secret
  fi
  echo "  $key: '$encoded_value'" >> manifests/$FILE_NAME.yaml
done < "$ENV_FILE"

echo "$KIND created in manifests/$FILE_NAME.yaml"
exit 0