#!/usr/bin/env bash
set -euo pipefail

SERVER_URL="${SERVER_URL:-http://localhost:8080}"
REALM="${REALM:-master}"
USER_NAME="${USER_NAME:-admin}"
USER_PASSWORD="${USER_PASSWORD:-changeit}"

docker exec keycloak /opt/keycloak/bin/kcadm.sh config credentials   --server "${SERVER_URL}"   --realm "${REALM}"   --user "${USER_NAME}"   --password "${USER_PASSWORD}"
