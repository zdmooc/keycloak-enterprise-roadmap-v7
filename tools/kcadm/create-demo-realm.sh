#!/usr/bin/env bash
set -euo pipefail

KCADM="${KCADM:-kcadm.sh}"
SERVER="${SERVER:-http://localhost:8080}"
REALM="${REALM:-demo}"

"$KCADM" create realms -s realm="$REALM" -s enabled=true --server "$SERVER"
echo "Realm $REALM created"
