# Déploiement Keycloak sur CodeReady Containers (CRC)

> **Auteur** : Zidane Djamal - Expert IAM / DevOps  
> **Contexte** : Ce répertoire fournit une méthode complète et industrialisée pour déployer Keycloak sur un environnement OpenShift local (CRC) via le Keycloak Operator.

## Objectif

L'objectif de ce laboratoire est de reproduire fidèlement un environnement OpenShift d'entreprise sur un poste local pour valider :
1. Le déploiement de Keycloak via l'Operator certifié Red Hat.
2. La configuration de la base de données PostgreSQL.
3. L'exposition sécurisée via les Routes OpenShift.
4. La gestion des secrets et la persistance des données.

## Architecture

L'architecture déployée sur CRC comprend :
- **Namespace** : `keycloak-system`
- **Base de données** : PostgreSQL 15 (StatefulSet avec PersistentVolumeClaim)
- **Operator** : Keycloak Operator OLM (Operator Lifecycle Manager)
- **Keycloak** : Instance Keycloak (Custom Resource `Keycloak`)
- **Exposition** : Route OpenShift avec terminaison TLS Edge.

## Prérequis

1. **Matériel** : 4 vCPU, 9 GB RAM minimum (recommandé : 16 GB pour CRC).
2. **Logiciel** :
   - [Red Hat CodeReady Containers (CRC)](https://developers.redhat.com/products/crc/overview) installé et configuré.
   - CLI `oc` (OpenShift Client).
   - CLI `jq` pour le parsing JSON.

## Démarrage Rapide

Un script d'installation de bout en bout est fourni pour automatiser le processus complet.

```bash
# 1. Démarrer CRC (si ce n'est pas déjà fait)
crc start

# 2. Se connecter en tant que cluster-admin
oc login -u kubeadmin -p $(crc console --credentials -o json | jq -r .clusterConfig.adminCredentials.password) https://api.crc.testing:6443

# 3. Lancer le script de déploiement complet
./scripts/deploy-keycloak-crc.sh
```

## Structure des Manifests

Les manifests sont organisés pour refléter une approche déclarative propre :

- `manifests/00-namespace.yaml` : Création du projet/namespace.
- `manifests/01-operator-group.yaml` : Configuration OLM pour l'Operator.
- `manifests/02-subscription.yaml` : Souscription à l'Operator Keycloak.
- `manifests/03-postgres.yaml` : Déploiement de la base de données (Service, StatefulSet, PVC).
- `manifests/04-keycloak-secrets.yaml` : Secrets pour la DB et l'admin Keycloak.
- `manifests/05-keycloak-cr.yaml` : Custom Resource Keycloak.

## Vérification et Tests

Une fois le déploiement terminé, vous pouvez vérifier l'état du cluster :

```bash
# Vérifier l'état de l'Operator
oc get csv -n keycloak-system

# Vérifier les Pods
oc get pods -n keycloak-system

# Obtenir l'URL de Keycloak
oc get route keycloak -n keycloak-system -o jsonpath='{.spec.host}{"\n"}'
```

Pour vous connecter à la console d'administration :
- **URL** : `https://<ROUTE_HOST>`
- **Utilisateur** : `admin`
- **Mot de passe** : `adminadmin` (défini dans `04-keycloak-secrets.yaml`)

## Nettoyage (Teardown)

Pour supprimer l'environnement proprement :

```bash
./scripts/teardown-crc.sh
```

## Prochaines Étapes

Une fois ce laboratoire maîtrisé, vous serez prêt à aborder le déploiement sur des clusters Kubernetes standards (Kind) ou des environnements Cloud managés (AWS EKS, GCP GKE, Azure AKS) détaillés dans les sections suivantes.
