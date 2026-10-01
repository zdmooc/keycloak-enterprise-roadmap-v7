#!/usr/bin/env bash
set -euo pipefail

rm -rf build
mkdir -p build

kubectl kustomize manifests/kustomize > build/keycloak-reference.yaml
test -s build/keycloak-reference.yaml

KC_BOOTSTRAP_ADMIN_PASSWORD=ci-not-a-real-secret POSTGRES_PASSWORD=ci-not-a-real-secret KC_DB_PASSWORD=ci-not-a-real-secret docker compose -f labs/00-local-compose/docker-compose.yml config >/dev/null

(
  cd scenarios/01-keycloak-oauth2-proxy-traefik-whoami
  ./scripts/prepare.sh
  docker compose --env-file .env -f compose/docker-compose.yml config >/dev/null
)

echo "KEYCLOAK_RENDER_ACTIVE=PASS"
