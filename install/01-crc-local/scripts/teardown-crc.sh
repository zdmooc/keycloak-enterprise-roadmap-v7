#!/bin/bash
# Auteur : Zidane Djamal
# Description : Suppression propre de l'environnement Keycloak sur CRC.

set -e

NAMESPACE="keycloak-system"

echo "Suppression de l'instance Keycloak (Custom Resource)..."
oc delete keycloak keycloak -n $NAMESPACE --ignore-not-found=true

echo "Suppression de PostgreSQL..."
oc delete statefulset postgresql -n $NAMESPACE --ignore-not-found=true
oc delete service postgresql -n $NAMESPACE --ignore-not-found=true
oc delete pvc postgres-pvc -n $NAMESPACE --ignore-not-found=true

echo "Suppression des Secrets..."
oc delete secret keycloak-db-secret keycloak-admin-secret -n $NAMESPACE --ignore-not-found=true

echo "Désinstallation de l'Operator Keycloak (Subscription et CSV)..."
oc delete subscription rhbk-operator -n $NAMESPACE --ignore-not-found=true
CSV=$(oc get csv -n $NAMESPACE -o name | grep rhbk || true)
if [ -n "$CSV" ]; then
  oc delete $CSV -n $NAMESPACE
fi

echo "Suppression du Namespace $NAMESPACE..."
oc delete project $NAMESPACE --ignore-not-found=true

echo "Nettoyage terminé."
