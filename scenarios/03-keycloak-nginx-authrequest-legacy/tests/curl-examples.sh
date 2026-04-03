#!/usr/bin/env bash
set -euo pipefail

echo "Unauthenticated request"
curl -i http://localhost:8080/ || true

echo "Direct backend request should fail in hardened setup"
echo "This test is valid only if the legacy backend is not published."
