#!/usr/bin/env bash
set -euo pipefail

KCADM="${KCADM:-kcadm.sh}"
SERVER="${SERVER:-http://localhost:8080}"
REALM="${REALM:-demo}"

"$KCADM" create clients -r "$REALM" --server "$SERVER"   -s clientId=demo-api   -s enabled=true   -s publicClient=false   -s serviceAccountsEnabled=true   -s protocol=openid-connect

echo "Client demo-api created in realm $REALM"
