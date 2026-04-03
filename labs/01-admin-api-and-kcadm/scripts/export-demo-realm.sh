#!/usr/bin/env bash
set -euo pipefail

mkdir -p ../evidence
TOKEN=$(curl -s -X POST "http://localhost:8080/realms/master/protocol/openid-connect/token"   -H "Content-Type: application/x-www-form-urlencoded"   -d "username=${ADMIN_USER:-admin}"   -d "password=${ADMIN_PASSWORD:-changeit}"   -d "grant_type=password"   -d "client_id=admin-cli" | jq -r '.access_token')

curl -s "http://localhost:8080/admin/realms/demo"   -H "Authorization: Bearer ${TOKEN}"   > ../evidence/realm-demo-export.json

echo "Export written to ../evidence/realm-demo-export.json"
