#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCENARIO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${SCENARIO_DIR}"

test -f .env || { echo "Run make up first."; exit 1; }
set -a
source .env
set +a

echo "== checking containers"
docker compose --env-file .env -f compose/docker-compose.yml ps

echo "== waiting for Keycloak discovery endpoint"
attempts=0
until curl -fsS "${KEYCLOAK_EXTERNAL_URL}/realms/${OIDC_REALM}/.well-known/openid-configuration" >/dev/null 2>&1; do
  attempts=$((attempts+1))
  if [ "$attempts" -ge 60 ]; then
    echo "Keycloak discovery endpoint is not ready after 60 attempts."
    exit 1
  fi
  sleep 2
done

echo "== checking Keycloak base URL"
curl -fsS "${KEYCLOAK_EXTERNAL_URL}/" >/dev/null

echo "== checking whoami route returns an auth redirect"
headers="$(mktemp)"
trap 'rm -f "$headers"' EXIT
curl -sSI "${WHOAMI_EXTERNAL_URL}/" > "$headers"

if ! grep -qiE '^HTTP/.* 302' "$headers"; then
  echo "Expected an HTTP 302 on ${WHOAMI_EXTERNAL_URL}/"
  exit 1
fi

if ! grep -qi 'Location: .*openid-connect/auth' "$headers"; then
  echo "Expected a redirect to the OIDC authorization endpoint."
  exit 1
fi

echo "== checking Traefik dashboard endpoint"
curl -fsS http://localhost:8089/dashboard/ >/dev/null || true

echo "SCENARIO_OIDC_DISCOVERY=PASS"
echo "SCENARIO_AUTH_REDIRECT=PASS"
echo "SCENARIO_SMOKE=PASS"
echo "Open ${WHOAMI_EXTERNAL_URL}/ and use the locally generated demo credentials from .env."
