#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST_DIR="$(cd "$SCRIPT_DIR/../manifests" && pwd)"

CLUSTER_NAME="${CLUSTER_NAME:-keycloak-cluster}"
NAMESPACE="${NAMESPACE:-keycloak-system}"
KEYCLOAK_VERSION="${KEYCLOAK_VERSION:-26.8.0}"

: "${KC_DB_USERNAME:?set KC_DB_USERNAME}"
: "${KC_DB_PASSWORD:?set KC_DB_PASSWORD}"

command -v kind >/dev/null 2>&1 || { echo "kind is required"; exit 1; }
command -v kubectl >/dev/null 2>&1 || { echo "kubectl is required"; exit 1; }

if ! kind get clusters | grep -qx "$CLUSTER_NAME"; then
  kind create cluster --name "$CLUSTER_NAME"
fi

kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
cat >"$tmp/kustomization.yaml" <<EOF
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: $NAMESPACE
resources:
  - github.com/keycloak/keycloak-k8s-resources/kubernetes?ref=$KEYCLOAK_VERSION
EOF

echo "== Keycloak Operator $KEYCLOAK_VERSION"
kubectl apply -k "$tmp"
kubectl -n "$NAMESPACE" rollout status deployment/keycloak-operator --timeout=240s

echo "== Database credential Secret created at runtime"
kubectl -n "$NAMESPACE" create secret generic keycloak-db-secret   --from-literal=username="$KC_DB_USERNAME"   --from-literal=password="$KC_DB_PASSWORD"   --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f "$MANIFEST_DIR/02-postgres.yaml"
kubectl -n "$NAMESPACE" rollout status statefulset/postgresql --timeout=240s

kubectl apply -f "$MANIFEST_DIR/03-keycloak-cr.yaml"
kubectl -n "$NAMESPACE" wait --for=condition=Ready keycloak/keycloak --timeout=600s

kubectl apply -f "$MANIFEST_DIR/04-keycloak-ingress.yaml"

echo "KIND_KEYCLOAK_DEPLOY=PASS"
echo "Operator-generated initial admin Secret: keycloak-initial-admin"
echo "No credential value is printed or stored by this script."
