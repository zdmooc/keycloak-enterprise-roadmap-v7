#!/usr/bin/env bash
set -euo pipefail

REALM="${REALM:-demo}"
OUT="${OUT:-realm-demo-export.json}"

echo "Use Keycloak export tooling or Admin API for logical export."
echo "Target file: $OUT"
