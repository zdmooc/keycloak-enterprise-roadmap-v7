#!/usr/bin/env bash
set -euo pipefail

required=(docker)
for bin in "${required[@]}"; do
  command -v "$bin" >/dev/null 2>&1 || { echo "Missing dependency: $bin"; exit 1; }
done

if ! docker compose version >/dev/null 2>&1; then
  echo "Docker Compose v2 is required."
  exit 1
fi

ports=(8080 8088 8089 4180)
for port in "${ports[@]}"; do
  if command -v lsof >/dev/null 2>&1; then
    if lsof -iTCP:"$port" -sTCP:LISTEN >/dev/null 2>&1; then
      echo "Port $port already in use"
      exit 1
    fi
  fi
done

echo "Preflight OK"
echo "If *.localhost does not resolve on your workstation, add these entries:"
echo "127.0.0.1 keycloak.localhost"
echo "127.0.0.1 whoami.localhost"
