#!/bin/bash
# Auteur : Zidane Djamal
# Description : Script d'import de la configuration Realm Keycloak via kcadm.sh.
# Utilisé dans les pipelines CI/CD pour le déploiement "Realm as Code".
#
# Usage : ./realm-import.sh <KC_URL> <ADMIN_USER> <ADMIN_PASSWORD> <ENV>
#
# Arguments :
#   KC_URL         : URL de l'instance Keycloak cible (ex: https://keycloak.example.com)
#   ADMIN_USER     : Nom d'utilisateur de l'administrateur Keycloak
#   ADMIN_PASSWORD : Mot de passe de l'administrateur Keycloak
#   ENV            : Environnement cible (dev, staging, prod)

set -e

KC_URL="${1:?Erreur: KC_URL est requis}"
ADMIN_USER="${2:?Erreur: ADMIN_USER est requis}"
ADMIN_PASSWORD="${3:?Erreur: ADMIN_PASSWORD est requis}"
ENV="${4:?Erreur: ENV est requis}"

KCADM="/opt/keycloak/bin/kcadm.sh"
REALM_FILE="realms/enterprise-realm-${ENV}.json"

echo "=================================================================="
echo "  Import Realm Keycloak - Environnement : ${ENV}"
echo "  Cible : ${KC_URL}"
echo "=================================================================="

# Vérification que le fichier de realm existe
if [ ! -f "$REALM_FILE" ]; then
  echo "AVERTISSEMENT : Fichier de realm spécifique à l'environnement non trouvé : $REALM_FILE"
  echo "Utilisation du fichier de realm par défaut : realms/enterprise-realm.json"
  REALM_FILE="realms/enterprise-realm.json"
fi

if [ ! -f "$REALM_FILE" ]; then
  echo "ERREUR : Aucun fichier de realm trouvé. Vérifiez le répertoire realms/."
  exit 1
fi

echo "[1/4] Authentification auprès de Keycloak..."
$KCADM config credentials \
  --server "${KC_URL}" \
  --realm master \
  --user "${ADMIN_USER}" \
  --password "${ADMIN_PASSWORD}"

echo "[2/4] Vérification de l'existence du realm 'enterprise'..."
REALM_EXISTS=$($KCADM get realms/enterprise --fields realm 2>/dev/null | jq -r '.realm // empty' || echo "")

if [ -n "$REALM_EXISTS" ]; then
  echo "[3/4] Le realm 'enterprise' existe déjà. Mise à jour de la configuration..."
  # Pour une mise à jour, on utilise l'API d'import partiel
  $KCADM update realms/enterprise -f "$REALM_FILE"
else
  echo "[3/4] Création du realm 'enterprise' depuis le fichier $REALM_FILE..."
  $KCADM create realms -f "$REALM_FILE"
fi

echo "[4/4] Vérification post-déploiement..."
REALM_STATUS=$($KCADM get realms/enterprise --fields enabled | jq -r '.enabled')
if [ "$REALM_STATUS" = "true" ]; then
  echo "Realm 'enterprise' déployé et activé avec succès sur ${ENV}."
else
  echo "ERREUR : Le realm 'enterprise' n'est pas activé après le déploiement."
  exit 1
fi

echo "=================================================================="
echo "  Import Realm terminé avec succès sur ${ENV}"
echo "=================================================================="
