#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST_DIR="$(cd "$SCRIPT_DIR/../manifests" && pwd)"
NAMESPACE="${NAMESPACE:-keycloak-system}"

: "${KC_DB_USERNAME:?set KC_DB_USERNAME}"
: "${KC_DB_PASSWORD:?set KC_DB_PASSWORD}"

command -v oc >/dev/null 2>&1 || { echo "oc CLI is required"; exit 1; }
oc whoami >/dev/null

echo "== Namespace"
oc apply -f "$MANIFEST_DIR/00-namespace.yaml"

echo "== RHBK Operator"
oc apply -f "$MANIFEST_DIR/01-operator-group.yaml"
oc apply -f "$MANIFEST_DIR/02-subscription.yaml"

echo "Waiting for the Red Hat build of Keycloak Operator CSV..."
for _ in $(seq 1 120); do
  if oc -n "$NAMESPACE" get csv -o jsonpath='{range .items[*]}{.metadata.name}{" "}{.status.phase}{"\n"}{end}'     | grep -E 'rhbk|keycloak' | grep -q Succeeded; then
    break
  fi
  sleep 5
done

oc -n "$NAMESPACE" get csv

echo "== Database credential Secret created at runtime"
oc -n "$NAMESPACE" create secret generic keycloak-db-secret   --from-literal=username="$KC_DB_USERNAME"   --from-literal=password="$KC_DB_PASSWORD"   --dry-run=client -o yaml | oc apply -f -

echo "== PostgreSQL lab database"
oc apply -f "$MANIFEST_DIR/03-postgres.yaml"
oc -n "$NAMESPACE" rollout status statefulset/postgresql --timeout=300s

echo "== Keycloak CR"
oc apply -f "$MANIFEST_DIR/05-keycloak-cr.yaml"
set +e
oc -n "$NAMESPACE" wait --for=condition=Ready keycloak/keycloak --timeout=600s
kc_wait_rc=$?
set -e

if [[ "$kc_wait_rc" -ne 0 ]]; then
  echo "== Keycloak readiness diagnostics"
  oc -n "$NAMESPACE" get keycloak keycloak -o yaml || true
  oc -n "$NAMESPACE" get pods,deploy,statefulset,svc,route,ingress -o wide 2>/dev/null || true
  oc -n "$NAMESPACE" describe keycloak keycloak || true
  oc -n "$NAMESPACE" describe pods || true
  oc -n "$NAMESPACE" get events --sort-by=.lastTimestamp | tail -n 120 || true
  exit "$kc_wait_rc"
fi

echo "== Result"
oc -n "$NAMESPACE" get keycloak keycloak -o wide
oc -n "$NAMESPACE" get pods,svc,route,ingress 2>/dev/null || true

echo "CRC_KEYCLOAK_DEPLOY=PASS"
echo "The Operator-generated initial admin credential is stored in keycloak-initial-admin."
echo "Retrieve it only when needed and never commit its value."
