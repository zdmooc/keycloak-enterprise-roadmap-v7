#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCENARIO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${SCENARIO_DIR}"

./scripts/prepare.sh
./scripts/preflight.sh

docker compose --env-file .env -f compose/docker-compose.yml up -d
docker compose --env-file .env -f compose/docker-compose.yml ps

echo "SCENARIO_UP=PASS"
echo "Credentials were generated in the local .env file and were not printed."
