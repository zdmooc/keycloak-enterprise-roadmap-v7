#!/usr/bin/env bash
set -euo pipefail

CID=$(docker exec keycloak /opt/keycloak/bin/kcadm.sh get clients -r demo -q clientId=demo-api --fields id,clientId | jq -r '.[0].id // empty')

if [[ -z "${CID}" ]]; then
  docker exec keycloak /opt/keycloak/bin/kcadm.sh create clients -r demo     -s clientId=demo-api     -s enabled=true     -s protocol=openid-connect     -s publicClient=false     -s serviceAccountsEnabled=true     -s standardFlowEnabled=false     -s directAccessGrantsEnabled=false
  echo "Client demo-api created."
else
  echo "Client demo-api already exists."
fi
