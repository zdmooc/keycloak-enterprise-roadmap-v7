#!/usr/bin/env bash
set -euo pipefail

SERVER_URL="${SERVER_URL:-http://localhost:8080}"
MASTER_REALM="${MASTER_REALM:-master}"
ADMIN_USER="${ADMIN_USER:-admin}"
ADMIN_PASSWORD="${ADMIN_PASSWORD:-changeit}"

docker exec keycloak /opt/keycloak/bin/kcadm.sh config credentials   --server "${SERVER_URL}"   --realm "${MASTER_REALM}"   --user "${ADMIN_USER}"   --password "${ADMIN_PASSWORD}"

echo "Admin authentication configured."
