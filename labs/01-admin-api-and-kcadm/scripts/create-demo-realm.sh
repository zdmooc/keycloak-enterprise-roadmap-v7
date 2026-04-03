#!/usr/bin/env bash
set -euo pipefail

docker exec keycloak /opt/keycloak/bin/kcadm.sh get realms/demo >/dev/null 2>&1   && echo "Realm demo already exists"   || docker exec keycloak /opt/keycloak/bin/kcadm.sh create realms -s realm=demo -s enabled=true

docker exec keycloak /opt/keycloak/bin/kcadm.sh create roles -r demo -s name=app-user >/dev/null 2>&1 || true
docker exec keycloak /opt/keycloak/bin/kcadm.sh create groups -r demo -s name=employees >/dev/null 2>&1 || true

echo "Realm demo initialized."
