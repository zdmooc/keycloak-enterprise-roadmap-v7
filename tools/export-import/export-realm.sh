#!/usr/bin/env bash
set -euo pipefail

REALM_NAME="${REALM_NAME:-demo}"
BASE_URL="${BASE_URL:-http://localhost:8080}"
ADMIN_USER="${ADMIN_USER:-admin}"
: "${ADMIN_PASSWORD:?set ADMIN_PASSWORD at runtime}"
OUT_DIR="${OUT_DIR:-./evidence}"
mkdir -p "${OUT_DIR}"

TOKEN="$(curl -fsS -X POST "${BASE_URL}/realms/master/protocol/openid-connect/token"   -H "Content-Type: application/x-www-form-urlencoded"   --data-urlencode "username=${ADMIN_USER}"   --data-urlencode "password=${ADMIN_PASSWORD}"   --data-urlencode "grant_type=password"   --data-urlencode "client_id=admin-cli" | jq -r '.access_token')"

test -n "${TOKEN}" && test "${TOKEN}" != "null"

curl -fsS "${BASE_URL}/admin/realms/${REALM_NAME}"   -H "Authorization: Bearer ${TOKEN}" > "${OUT_DIR}/${REALM_NAME}.json"

unset TOKEN
echo "Exported realm ${REALM_NAME} to ${OUT_DIR}/${REALM_NAME}.json"
