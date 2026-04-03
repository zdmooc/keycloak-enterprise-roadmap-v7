#!/usr/bin/env bash
set -euo pipefail

KCADM_BIN="${KCADM_BIN:-kcadm.sh}"
SERVER="${SERVER:-http://localhost:8080}"
REALM="${REALM:-master}"
USER="${USER:-admin}"
PASSWORD="${PASSWORD:-changeit}"

"${KCADM_BIN}" config credentials   --server "${SERVER}"   --realm "${REALM}"   --user "${USER}"   --password "${PASSWORD}"

echo "Authenticated against ${SERVER} / realm ${REALM}"
