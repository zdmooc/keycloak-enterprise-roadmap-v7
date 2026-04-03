#!/usr/bin/env bash
set -euo pipefail
HEALTH_URL="${HEALTH_URL:-http://localhost:9000/health/ready}"
curl -fsS "${HEALTH_URL}"
echo
