#!/bin/bash
# Auteur : Zidane Djamal
# Description : Script de déploiement automatisé de Keycloak sur CRC (OpenShift local) via l'Operator.

set -e

echo "=================================================================="
echo "  Déploiement Keycloak sur CodeReady Containers (CRC) - OpenShift "
echo "=================================================================="

NAMESPACE="keycloak-system"

echo "[1/7] Création du projet/namespace : $NAMESPACE"
oc new-project $NAMESPACE || true
oc project $NAMESPACE

echo "[2/7] Configuration de l'OperatorGroup et Subscription (OLM)"
oc apply -f ../manifests/01-operator-group.yaml
oc apply -f ../manifests/02-subscription.yaml

echo "Attente de l'installation de l'Operator Keycloak (cela peut prendre quelques minutes)..."
sleep 10
oc wait --for=condition=Ready pod -l name=keycloak-operator -n $NAMESPACE --timeout=300s

echo "[3/7] Création des Secrets (Base de données et Admin Keycloak)"
oc apply -f ../manifests/04-keycloak-secrets.yaml

echo "[4/7] Déploiement de PostgreSQL"
oc apply -f ../manifests/03-postgres.yaml
oc wait --for=condition=Ready pod -l app=postgresql -n $NAMESPACE --timeout=300s

echo "[5/7] Déploiement de l'instance Keycloak (Custom Resource)"
oc apply -f ../manifests/05-keycloak-cr.yaml

echo "[6/7] Attente de la disponibilité de Keycloak"
oc wait --for=condition=Ready keycloak/keycloak -n $NAMESPACE --timeout=600s

echo "[7/7] Récupération de la Route (URL d'accès)"
ROUTE_HOST=$(oc get route keycloak -n $NAMESPACE -o jsonpath='{.spec.host}')

echo "=================================================================="
echo "  Déploiement Terminé avec Succès !                               "
echo "=================================================================="
echo "URL d'accès : https://$ROUTE_HOST"
echo "Utilisateur : admin"
echo "Mot de passe: adminadmin (défini dans 04-keycloak-secrets.yaml)"
echo "=================================================================="
