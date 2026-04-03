#!/usr/bin/env bash
set -euo pipefail
KCADM_BIN="${KCADM_BIN:-kcadm.sh}"
"${KCADM_BIN}" get realms
