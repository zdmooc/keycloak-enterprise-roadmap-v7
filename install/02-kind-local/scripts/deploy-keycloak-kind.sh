#!/bin/bash
# Auteur : Zidane Djamal
# Description : Script de déploiement automatisé de Keycloak sur un cluster Kind (Kubernetes local).

set -e

echo "=================================================================="
echo "  Déploiement Keycloak sur Kubernetes in Docker (Kind)            "
echo "=================================================================="

CLUSTER_NAME="keycloak-cluster"
NAMESPACE="keycloak-system"

echo "[1/8] Création du cluster Kind avec NGINX Ingress Controller"
cat <<EOF | kind create cluster --name $CLUSTER_NAME --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF

echo "[2/8] Installation du NGINX Ingress Controller"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
echo "Attente de l'Ingress Controller..."
sleep 10
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

echo "[3/8] Création du Namespace : $NAMESPACE"
kubectl create namespace $NAMESPACE || true

echo "[4/8] Installation des CRDs de l'Operator Keycloak"
kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/26.1.0/kubernetes/crd.yaml

echo "[5/8] Déploiement de l'Operator Keycloak"
kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/26.1.0/kubernetes/kubernetes.yml -n $NAMESPACE
echo "Attente de l'Operator..."
sleep 5
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=keycloak-operator -n $NAMESPACE --timeout=120s

echo "[6/8] Création des Secrets et Déploiement de PostgreSQL"
# Simulé ici, les manifests devraient être créés (voir README)
kubectl apply -f ../manifests/01-postgres-secret.yaml -n $NAMESPACE
kubectl apply -f ../manifests/02-postgres.yaml -n $NAMESPACE
echo "Attente de PostgreSQL..."
sleep 5
kubectl wait --for=condition=ready pod -l app=postgresql -n $NAMESPACE --timeout=120s

echo "[7/8] Déploiement de l'instance Keycloak"
kubectl apply -f ../manifests/03-keycloak-cr.yaml -n $NAMESPACE
echo "Attente de Keycloak..."
sleep 10
kubectl wait --for=condition=ready keycloak/keycloak -n $NAMESPACE --timeout=300s

echo "[8/8] Création de l'Ingress Keycloak"
kubectl apply -f ../manifests/04-keycloak-ingress.yaml -n $NAMESPACE

echo "=================================================================="
echo "  Déploiement Terminé avec Succès !                               "
echo "=================================================================="
echo "Veuillez ajouter '127.0.0.1 keycloak.local' à votre /etc/hosts"
echo "URL d'accès : http://keycloak.local"
echo "Utilisateur : admin"
echo "Mot de passe: adminadmin"
echo "=================================================================="
