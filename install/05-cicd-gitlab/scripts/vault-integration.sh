#!/bin/bash
# Auteur : Zidane Djamal
# Description : Script d'intégration HashiCorp Vault pour les pipelines CI/CD GitLab.
# Ce script illustre comment récupérer les secrets Keycloak depuis Vault
# en utilisant l'authentification JWT (méthode recommandée pour GitLab CI).
#
# Prérequis côté Vault :
#   1. Méthode d'authentification JWT activée : vault auth enable jwt
#   2. Rôle configuré pour GitLab CI :
#      vault write auth/jwt/role/gitlab-keycloak-deploy \
#        bound_audiences="https://gitlab.example.com" \
#        bound_claims='{"project_path": "votre-groupe/votre-projet"}' \
#        user_claim="sub" \
#        policies="keycloak-deploy-policy" \
#        ttl=1h
#   3. Secrets stockés dans Vault :
#      vault kv put secret/keycloak/admin username=admin password=SuperSecret
#      vault kv put secret/keycloak/db username=keycloak password=DbSecret

set -e

VAULT_ADDR="${VAULT_ADDR:?Erreur: VAULT_ADDR est requis}"
VAULT_ROLE="${VAULT_ROLE:?Erreur: VAULT_ROLE est requis}"
# CI_JOB_JWT_V2 est automatiquement fourni par GitLab CI
JWT_TOKEN="${CI_JOB_JWT_V2:?Erreur: CI_JOB_JWT_V2 est requis (doit être exécuté dans GitLab CI)}"

echo "[1/4] Authentification auprès de Vault via JWT GitLab CI..."
VAULT_TOKEN=$(vault write -field=token auth/jwt/login \
  role="${VAULT_ROLE}" \
  jwt="${JWT_TOKEN}")

if [ -z "$VAULT_TOKEN" ]; then
  echo "ERREUR : Impossible d'obtenir un token Vault."
  exit 1
fi
export VAULT_TOKEN

echo "[2/4] Récupération des credentials Keycloak Admin..."
export KC_ADMIN_USER=$(vault kv get -field=username secret/keycloak/admin)
export KC_ADMIN_PASSWORD=$(vault kv get -field=password secret/keycloak/admin)

echo "[3/4] Récupération des credentials de la base de données..."
export KC_DB_USER=$(vault kv get -field=username secret/keycloak/db)
export KC_DB_PASSWORD=$(vault kv get -field=password secret/keycloak/db)

echo "[4/4] Révocation du token Vault (bonne pratique - utilisation unique)..."
vault token revoke -self

echo "Secrets récupérés avec succès. Variables d'environnement exportées."
echo "  KC_ADMIN_USER     : ${KC_ADMIN_USER}"
echo "  KC_ADMIN_PASSWORD : [MASQUÉ]"
echo "  KC_DB_USER        : ${KC_DB_USER}"
echo "  KC_DB_PASSWORD    : [MASQUÉ]"
