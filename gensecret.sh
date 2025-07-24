#!/bin/bash
ENV_FILE=".env"
SECRET_NAME="denkettle-secret"
NAMESPACE="default"

echo "apiVersion: v1
kind: Secret
metadata:
  name: $SECRET_NAME
  namespace: $NAMESPACE
type: Opaque
data:" > manifests/$SECRET_NAME.yaml

while IFS='=' read -r key value || [[ -n "$key" ]]; do
  [[ "$key" == \#* || -z "$key" ]] && continue
  encoded_value=$(echo -n "$value" | base64)
  echo "  $key: $encoded_value" >> manifests/$SECRET_NAME.yaml
done < "$ENV_FILE"

echo "Secret created in manifests/$SECRET_NAME.yaml"