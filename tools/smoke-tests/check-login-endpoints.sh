#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8080}"
REALM="${REALM:-master}"

echo "Checking OIDC discovery document..."
curl -fsS "${BASE_URL}/realms/${REALM}/.well-known/openid-configuration" >/dev/null
echo "OK"
