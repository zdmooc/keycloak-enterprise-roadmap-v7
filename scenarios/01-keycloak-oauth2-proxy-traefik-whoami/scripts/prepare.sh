#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCENARIO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
export SCENARIO_DIR

python3 - <<'PY'
from __future__ import annotations
import json
import os
import pathlib
import secrets

root = pathlib.Path(os.environ["SCENARIO_DIR"])
example = root / "env" / ".env.example"
env_file = root / ".env"
template = root / "realm" / "demo-realm.template.json"
generated_dir = root / "generated"
generated = generated_dir / "demo-realm.json"

def parse_env(path: pathlib.Path) -> dict[str, str]:
    out = {}
    if not path.exists():
        return out
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        k, v = line.split("=", 1)
        out[k] = v
    return out

values = parse_env(example)
values.update(parse_env(env_file))

defaults = {
    "KC_BOOTSTRAP_ADMIN_USERNAME": "admin",
    "OIDC_REALM": "demo",
    "OIDC_CLIENT_ID": "whoami-proxy",
    "DEMO_USER_USERNAME": "demo",
    "WHOAMI_EXTERNAL_URL": "http://whoami.localhost:8088",
    "KEYCLOAK_EXTERNAL_URL": "http://keycloak.localhost:8080",
}
for k, v in defaults.items():
    values.setdefault(k, v)

for key in [
    "KC_BOOTSTRAP_ADMIN_PASSWORD",
    "OIDC_CLIENT_SECRET",
    "OAUTH2_PROXY_COOKIE_SECRET",
    "DEMO_USER_PASSWORD",
]:
    if not values.get(key):
        values[key] = secrets.token_urlsafe(24)

order = [
    "KC_BOOTSTRAP_ADMIN_USERNAME",
    "KC_BOOTSTRAP_ADMIN_PASSWORD",
    "OIDC_REALM",
    "OIDC_CLIENT_ID",
    "OIDC_CLIENT_SECRET",
    "OAUTH2_PROXY_COOKIE_SECRET",
    "DEMO_USER_USERNAME",
    "DEMO_USER_PASSWORD",
    "WHOAMI_EXTERNAL_URL",
    "KEYCLOAK_EXTERNAL_URL",
]
env_file.write_text("".join(f"{k}={values[k]}\n" for k in order), encoding="utf-8")
try:
    env_file.chmod(0o600)
except OSError:
    pass

realm = json.loads(template.read_text(encoding="utf-8"))
realm["realm"] = values["OIDC_REALM"]
realm["clients"][0]["clientId"] = values["OIDC_CLIENT_ID"]
realm["clients"][0]["secret"] = values["OIDC_CLIENT_SECRET"]
realm["users"][0]["username"] = values["DEMO_USER_USERNAME"]
realm["users"][0]["credentials"][0]["value"] = values["DEMO_USER_PASSWORD"]

generated_dir.mkdir(parents=True, exist_ok=True)
generated.write_text(json.dumps(realm, indent=2) + "\n", encoding="utf-8")
print("SCENARIO_SECRET_PREPARE=PASS")
print("Generated .env and generated/demo-realm.json locally; values were not printed.")
PY
