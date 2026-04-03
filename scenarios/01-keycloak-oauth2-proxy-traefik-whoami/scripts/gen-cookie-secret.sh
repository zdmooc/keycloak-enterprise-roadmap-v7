#!/usr/bin/env bash
set -euo pipefail
if command -v openssl >/dev/null 2>&1; then
  openssl rand -base64 32
else
  python3 - <<'PY'
import secrets, base64
print(base64.b64encode(secrets.token_bytes(32)).decode())
PY
fi
