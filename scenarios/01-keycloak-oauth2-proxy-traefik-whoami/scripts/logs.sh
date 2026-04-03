#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCENARIO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${SCENARIO_DIR}"
docker compose --env-file .env -f compose/docker-compose.yml logs -f --tail=100
