#!/bin/bash
# Auteur : Zidane Djamal
# Description : Smoke tests pour valider qu'une instance Keycloak est opérationnelle.
# Exécuté dans le pipeline CI/CD après chaque déploiement.
#
# Usage : ./smoke-tests.sh <KC_URL>

set -e

KC_URL="${1:?Erreur: KC_URL est requis}"
MANAGEMENT_URL="${KC_URL%:*}:9000"
REALM="enterprise"
FAILURES=0

echo "=================================================================="
echo "  Smoke Tests Keycloak"
echo "  URL : ${KC_URL}"
echo "=================================================================="

check() {
  local NAME="$1"
  local URL="$2"
  local EXPECTED_STATUS="${3:-200}"
  local RESPONSE
  local STATUS

  STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$URL")
  if [ "$STATUS" = "$EXPECTED_STATUS" ]; then
    echo "  [PASS] $NAME (HTTP $STATUS)"
  else
    echo "  [FAIL] $NAME - Attendu HTTP $EXPECTED_STATUS, obtenu HTTP $STATUS"
    FAILURES=$((FAILURES + 1))
  fi
}

echo ""
echo "--- Tests de santé (Management Interface) ---"
check "Health Live"  "${KC_URL}/health/live"  "200"
check "Health Ready" "${KC_URL}/health/ready" "200"
check "Metrics"      "${KC_URL}/metrics"      "200"

echo ""
echo "--- Tests des endpoints OIDC du Realm '${REALM}' ---"
check "OIDC Discovery Document" \
  "${KC_URL}/realms/${REALM}/.well-known/openid-configuration" "200"
check "JWKS (Clés publiques)" \
  "${KC_URL}/realms/${REALM}/protocol/openid-connect/certs" "200"
check "Token Endpoint (sans credentials - doit retourner 401)" \
  "${KC_URL}/realms/${REALM}/protocol/openid-connect/token" "401"

echo ""
echo "--- Tests de l'Admin API (sans auth - doit retourner 401) ---"
check "Admin API (non authentifié)" \
  "${KC_URL}/admin/realms" "401"

echo ""
echo "=================================================================="
if [ "$FAILURES" -eq 0 ]; then
  echo "  Résultat : TOUS LES TESTS PASSÉS ($FAILURES échec(s))"
  exit 0
else
  echo "  Résultat : ÉCHEC - $FAILURES test(s) ont échoué"
  exit 1
fi
