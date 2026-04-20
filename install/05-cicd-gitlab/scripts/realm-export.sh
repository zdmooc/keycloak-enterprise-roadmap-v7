#!/bin/bash
# Auteur : Zidane Djamal
# Description : Script d'export de la configuration Realm Keycloak via kcadm.sh.
# Permet de versionner la configuration d'un realm existant dans Git (Realm as Code).
#
# Usage : ./realm-export.sh <KC_URL> <ADMIN_USER> <ADMIN_PASSWORD> <REALM_NAME> <OUTPUT_FILE>

set -e

KC_URL="${1:?Erreur: KC_URL est requis}"
ADMIN_USER="${2:?Erreur: ADMIN_USER est requis}"
ADMIN_PASSWORD="${3:?Erreur: ADMIN_PASSWORD est requis}"
REALM_NAME="${4:-enterprise}"
OUTPUT_FILE="${5:-realms/${REALM_NAME}-realm-export.json}"

KCADM="/opt/keycloak/bin/kcadm.sh"

echo "=================================================================="
echo "  Export Realm Keycloak : ${REALM_NAME}"
echo "  Source : ${KC_URL}"
echo "  Destination : ${OUTPUT_FILE}"
echo "=================================================================="

echo "[1/3] Authentification auprès de Keycloak..."
$KCADM config credentials \
  --server "${KC_URL}" \
  --realm master \
  --user "${ADMIN_USER}" \
  --password "${ADMIN_PASSWORD}"

echo "[2/3] Export du realm '${REALM_NAME}'..."
mkdir -p "$(dirname "$OUTPUT_FILE")"
$KCADM get realms/${REALM_NAME} > "${OUTPUT_FILE}"

echo "[3/3] Nettoyage des données sensibles de l'export (secrets clients)..."
# Supprimer les secrets des clients de l'export pour ne pas les committer en clair
jq 'del(.clients[].secret)' "${OUTPUT_FILE}" > "${OUTPUT_FILE}.tmp" && mv "${OUTPUT_FILE}.tmp" "${OUTPUT_FILE}"

echo "Export terminé : ${OUTPUT_FILE}"
echo "IMPORTANT : Vérifiez le fichier avant de le committer dans Git."
echo "=================================================================="
