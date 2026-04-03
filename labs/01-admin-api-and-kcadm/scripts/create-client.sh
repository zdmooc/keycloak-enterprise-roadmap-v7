#!/usr/bin/env bash
set -euo pipefail
KCADM_BIN="${KCADM_BIN:-kcadm.sh}"
REALM_NAME="${REALM_NAME:-lab-realm}"
CLIENT_ID="${CLIENT_ID:-demo-client}"

"${KCADM_BIN}" create clients -r "${REALM_NAME}"   -s clientId="${CLIENT_ID}"   -s enabled=true   -s publicClient=true   -s 'redirectUris=["http://localhost:3000/*"]'

echo "Client ${CLIENT_ID} created in realm ${REALM_NAME}"
