#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8080}"
ADMIN_USER="${ADMIN_USER:-admin}"
: "${ADMIN_PASSWORD:?set ADMIN_PASSWORD at runtime}"

mkdir -p ../evidence
TOKEN="$(curl -fsS -X POST "${BASE_URL}/realms/master/protocol/openid-connect/token"   -H "Content-Type: application/x-www-form-urlencoded"   --data-urlencode "username=${ADMIN_USER}"   --data-urlencode "password=${ADMIN_PASSWORD}"   --data-urlencode "grant_type=password"   --data-urlencode "client_id=admin-cli" | jq -r '.access_token')"

test -n "${TOKEN}" && test "${TOKEN}" != "null"
curl -fsS "${BASE_URL}/admin/realms/demo"   -H "Authorization: Bearer ${TOKEN}" > ../evidence/realm-demo-export.json
unset TOKEN

echo "Export written to ../evidence/realm-demo-export.json"
