#!/usr/bin/env bash
set -euo pipefail

IMAGE="${KEYCLOAK_IMAGE:-quay.io/keycloak/keycloak:26.8.0}"
CONTAINER="${KEYCLOAK_CONTAINER:-keycloak-o6-ci}"
VOLUME="${KEYCLOAK_VOLUME:-keycloak-o6-ci-data}"
BASE_URL="http://127.0.0.1:8080"
MGMT_URL="http://127.0.0.1:9000"

ADMIN_USER="o6-admin"
ADMIN_PASS="$(python3 -c 'import secrets; print(secrets.token_urlsafe(24))')"
USER_PASS="$(python3 -c 'import secrets; print(secrets.token_urlsafe(24))')"
CLIENT_SECRET="$(python3 -c 'import secrets; print(secrets.token_urlsafe(32))')"

cleanup() {
  status=$?
  if [[ "$status" -ne 0 ]]; then
    echo "== Keycloak diagnostics"
    docker logs "$CONTAINER" --tail 200 2>/dev/null || true
  fi
  docker rm -f "$CONTAINER" >/dev/null 2>&1 || true
  docker volume rm "$VOLUME" >/dev/null 2>&1 || true
  exit "$status"
}
trap cleanup EXIT

start_keycloak() {
  docker rm -f "$CONTAINER" >/dev/null 2>&1 || true
  docker run -d \
    --name "$CONTAINER" \
    -p 127.0.0.1:8080:8080 \
    -p 127.0.0.1:9000:9000 \
    -v "$VOLUME:/opt/keycloak/data" \
    -e KC_BOOTSTRAP_ADMIN_USERNAME="$ADMIN_USER" \
    -e KC_BOOTSTRAP_ADMIN_PASSWORD="$ADMIN_PASS" \
    "$IMAGE" \
    start-dev \
      --health-enabled=true \
      --metrics-enabled=true \
      --http-management-port=9000 >/dev/null
}

wait_ready() {
  for _ in $(seq 1 120); do
    if curl -fsS "$MGMT_URL/health/ready" >/dev/null 2>&1; then
      return 0
    fi
    sleep 2
  done
  return 1
}

admin_token() {
  local response
  response="$(curl -fsS \
    -X POST "$BASE_URL/realms/master/protocol/openid-connect/token" \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'client_id=admin-cli' \
    --data-urlencode 'grant_type=password' \
    --data-urlencode "username=$ADMIN_USER" \
    --data-urlencode "password=$ADMIN_PASS")"

  RESPONSE="$response" python3 - <<'PY'
import json, os
obj = json.loads(os.environ["RESPONSE"])
token = obj.get("access_token")
if not token:
    raise SystemExit("admin access token missing")
print(token)
PY
}

expect_code() {
  local expected="$1"
  shift
  local code
  code="$(curl -sS -o /tmp/o6-http-body -w '%{http_code}' "$@")"
  if [[ "$code" != "$expected" ]]; then
    echo "Expected HTTP $expected, got $code"
    cat /tmp/o6-http-body
    return 1
  fi
}

service_token_check() {
  local response
  response="$(curl -fsS \
    -X POST "$BASE_URL/realms/o6-ci/protocol/openid-connect/token" \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'client_id=o6-service' \
    --data-urlencode "client_secret=$CLIENT_SECRET" \
    --data-urlencode 'grant_type=client_credentials')"

  RESPONSE="$response" python3 - <<'PY'
import json, os
obj = json.loads(os.environ["RESPONSE"])
token = obj.get("access_token", "")
assert token and token.count(".") == 2
PY
}

echo "== Start Keycloak 26.8.0"
start_keycloak
wait_ready
curl -fsS "$MGMT_URL/metrics" >/dev/null
echo "KEYCLOAK_CONTAINER_READY=PASS"
echo "KEYCLOAK_METRICS=PASS"

curl -fsS "$BASE_URL/realms/master/.well-known/openid-configuration" \
  | python3 -c 'import json,sys; o=json.load(sys.stdin); assert o["issuer"]; assert o["token_endpoint"]; assert o["authorization_endpoint"]'
echo "KEYCLOAK_OIDC_DISCOVERY=PASS"

TOKEN="$(admin_token)"
test -n "$TOKEN"

cat >/tmp/o6-realm.json <<'EOF'
{"realm":"o6-ci","enabled":true,"registrationAllowed":false}
EOF
expect_code 201 \
  -X POST "$BASE_URL/admin/realms" \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json' \
  --data-binary @/tmp/o6-realm.json
echo "KEYCLOAK_ADMIN_API_REALM_CREATE=PASS"

CLIENT_SECRET_ENV="$CLIENT_SECRET" python3 - <<'PY'
import json, os
obj = {
    "clientId": "o6-service",
    "enabled": True,
    "publicClient": False,
    "secret": os.environ["CLIENT_SECRET_ENV"],
    "standardFlowEnabled": False,
    "directAccessGrantsEnabled": False,
    "serviceAccountsEnabled": True,
}
with open("/tmp/o6-client.json", "w", encoding="utf-8") as f:
    json.dump(obj, f)
PY

expect_code 201 \
  -X POST "$BASE_URL/admin/realms/o6-ci/clients" \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json' \
  --data-binary @/tmp/o6-client.json

USER_PASS_ENV="$USER_PASS" python3 - <<'PY'
import json, os
obj = {
    "username": "alice",
    "enabled": True,
    "emailVerified": True,
    "credentials": [
        {"type": "password", "value": os.environ["USER_PASS_ENV"], "temporary": False}
    ],
}
with open("/tmp/o6-user.json", "w", encoding="utf-8") as f:
    json.dump(obj, f)
PY

expect_code 201 \
  -X POST "$BASE_URL/admin/realms/o6-ci/users" \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json' \
  --data-binary @/tmp/o6-user.json
echo "KEYCLOAK_ADMIN_API_CLIENT_USER=PASS"

service_token_check
unset TOKEN
echo "KEYCLOAK_CLIENT_CREDENTIALS_TOKEN=PASS"

echo "== Restart using the same local data volume"
docker stop "$CONTAINER" >/dev/null
docker rm "$CONTAINER" >/dev/null
start_keycloak
wait_ready

curl -fsS "$BASE_URL/realms/o6-ci/.well-known/openid-configuration" \
  | python3 -c 'import json,sys; o=json.load(sys.stdin); assert "/realms/o6-ci" in o["issuer"]'
service_token_check

echo "KEYCLOAK_RESTART_PERSISTENCE=PASS"
echo "KEYCLOAK_POST_RESTART_TOKEN=PASS"
echo "CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK=PASS"
echo "openshift_crc_claim=NOT_PROVEN"
