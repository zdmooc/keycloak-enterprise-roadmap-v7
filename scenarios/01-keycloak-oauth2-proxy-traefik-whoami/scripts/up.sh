#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCENARIO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${SCENARIO_DIR}"

if [ ! -f .env ]; then
  cp env/.env.example .env
fi

./scripts/preflight.sh
docker compose --env-file .env -f compose/docker-compose.yml up -d
docker compose --env-file .env -f compose/docker-compose.yml ps
