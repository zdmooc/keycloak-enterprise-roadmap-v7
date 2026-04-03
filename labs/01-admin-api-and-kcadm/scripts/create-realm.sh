#!/usr/bin/env bash
set -euo pipefail
KCADM_BIN="${KCADM_BIN:-kcadm.sh}"
REALM_NAME="${REALM_NAME:-lab-realm}"

"${KCADM_BIN}" create realms -s realm="${REALM_NAME}" -s enabled=true
echo "Realm ${REALM_NAME} created"
