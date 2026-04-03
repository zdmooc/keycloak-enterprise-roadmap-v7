#!/usr/bin/env bash
set -euo pipefail

REALM_NAME="${REALM_NAME:-demo}"
OUT_DIR="${OUT_DIR:-./evidence}"
mkdir -p "${OUT_DIR}"

TOKEN=$(curl -s -X POST "http://localhost:8080/realms/master/protocol/openid-connect/token"   -H "Content-Type: application/x-www-form-urlencoded"   -d "username=${ADMIN_USER:-admin}"   -d "password=${ADMIN_PASSWORD:-changeit}"   -d "grant_type=password"   -d "client_id=admin-cli" | jq -r '.access_token')

curl -s "http://localhost:8080/admin/realms/${REALM_NAME}"   -H "Authorization: Bearer ${TOKEN}"   > "${OUT_DIR}/${REALM_NAME}.json"

echo "Exported realm ${REALM_NAME} to ${OUT_DIR}/${REALM_NAME}.json"
