# Déploiement Keycloak sur Kubernetes in Docker (Kind)

> **Auteur** : Zidane Djamal - Expert IAM / DevOps  
> **Contexte** : Ce répertoire fournit une méthode complète et industrialisée pour déployer Keycloak sur un cluster Kubernetes local (Kind) en utilisant des manifests natifs et Helm.

## Objectif

Ce laboratoire permet de valider le déploiement de Keycloak sur un cluster Kubernetes standard, sans les spécificités d'OpenShift (comme les Routes). Il est idéal pour :
1. Tester des configurations Kubernetes pures (Ingress, Ingress Controller NGINX).
2. Valider le fonctionnement de Keycloak avec une base PostgreSQL externe (simulée).
3. Expérimenter avec Helm pour le déploiement de l'Operator Keycloak.

## Architecture

L'architecture déployée sur Kind comprend :
- **Cluster** : Kind (Kubernetes in Docker) avec un Ingress Controller NGINX intégré.
- **Namespace** : `keycloak-system`
- **Base de données** : PostgreSQL 15 (StatefulSet).
- **Operator** : Keycloak Operator déployé via les manifests officiels ou Helm.
- **Exposition** : Ingress Kubernetes standard (`keycloak.local`).

## Prérequis

1. **Docker** installé et fonctionnel.
2. **CLI `kind`** (Kubernetes in Docker).
3. **CLI `kubectl`**.
4. **CLI `helm`** (optionnel, pour la méthode Helm).

## Démarrage Rapide (Méthode Manifests)

Un script est fourni pour créer le cluster Kind avec Ingress et déployer Keycloak de bout en bout.

```bash
# 1. Lancer le script de déploiement complet
./scripts/deploy-keycloak-kind.sh
```

Ce script va :
1. Créer un cluster Kind nommé `keycloak-cluster` avec un NGINX Ingress Controller.
2. Installer les CRDs de l'Operator Keycloak.
3. Déployer l'Operator.
4. Déployer PostgreSQL.
5. Déployer l'instance Keycloak.
6. Configurer l'Ingress.

## Accès à Keycloak

Une fois le script terminé, Keycloak sera accessible via l'Ingress NGINX.

1. Ajoutez l'entrée suivante à votre fichier `/etc/hosts` (ou `C:\Windows\System32\drivers\etc\hosts` sous Windows) :
   ```
   127.0.0.1 keycloak.local
   ```
2. Ouvrez votre navigateur à l'adresse : `http://keycloak.local`
3. Connectez-vous avec :
   - **Utilisateur** : `admin`
   - **Mot de passe** : `adminadmin` (défini dans les secrets)

## Méthode Alternative (Helm)

Si vous préférez utiliser Helm pour gérer l'installation de Keycloak (souvent préféré en production pour la gestion du cycle de vie) :

```bash
# 1. Créer le cluster Kind
./scripts/create-kind-cluster.sh

# 2. Déployer via Helm (Bitnami ou Operator)
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install keycloak bitnami/keycloak -n keycloak-system --create-namespace -f helm/values.yaml
```

## Nettoyage (Teardown)

Pour supprimer le cluster Kind et toutes les ressources associées :

```bash
kind delete cluster --name keycloak-cluster
```
