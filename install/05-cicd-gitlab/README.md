# Pipelines CI/CD GitLab pour Keycloak

> **Auteur** : Zidane Djamal - Expert IAM / DevOps  
> **Contexte** : Ce répertoire contient les définitions de pipelines GitLab CI pour automatiser le cycle de vie de la configuration Keycloak (Realm as Code), les tests et les déploiements.

## Objectif

L'objectif de ces pipelines est de fournir une chaîne d'intégration et de déploiement continus (CI/CD) pour Keycloak. Cela permet de :
1. Gérer les configurations Keycloak (Realms, Clients, Rôles) comme du code source (Realm as Code).
2. Automatiser les tests de sécurité, de performance et d'intégration avant tout déploiement en production.
3. Assurer une promotion contrôlée des configurations entre les environnements (Dev → Staging → Prod).
4. Intégrer la gestion des secrets (Vault) dans le pipeline de déploiement.

## Structure du Répertoire

```text
05-cicd-gitlab/
├── .gitlab-ci.yml
├── pipelines/
│   ├── build.yml
│   ├── test.yml
│   └── deploy.yml
├── scripts/
│   ├── realm-export.sh
│   ├── realm-import.sh
│   └── vault-integration.sh
└── tests/
    ├── smoke-tests.sh
    └── k6-load-tests.js
```

## Description des Pipelines

Le fichier `.gitlab-ci.yml` principal orchestre l'ensemble du processus en incluant les pipelines spécifiques :

1. **Build (`pipelines/build.yml`)** :
   - Validation de la syntaxe des fichiers JSON de configuration des Realms.
   - Linting des scripts Bash et des fichiers Terraform (si utilisés conjointement).
   - (Optionnel) Build des images Docker personnalisées de Keycloak avec des extensions (SPI) spécifiques.

2. **Test (`pipelines/test.yml`)** :
   - Déploiement d'une instance Keycloak éphémère (ex: via Docker Compose ou Kind) pour les tests d'intégration.
   - Exécution des smoke tests (vérification des endpoints `/health/live`, `/health/ready`, `/metrics`).
   - Exécution de tests de charge basiques (k6) pour s'assurer qu'il n'y a pas de régression de performance.

3. **Deploy (`pipelines/deploy.yml`)** :
   - Récupération des secrets (ex: credentials de base de données, mots de passe admin) depuis HashiCorp Vault via l'intégration GitLab CI/Vault.
   - Déploiement de l'infrastructure (si Terraform est utilisé).
   - Application de la configuration Keycloak (Realm as Code) via l'Admin API (kcadm.sh) ou le provider Terraform Keycloak.
   - Promotion vers les environnements de Staging puis de Production (avec approbation manuelle).

## Intégration Vault

Le pipeline illustre comment intégrer HashiCorp Vault pour sécuriser les déploiements. Au lieu de stocker les secrets en clair dans les variables GitLab CI, le pipeline s'authentifie auprès de Vault (via JWT/OIDC) pour récupérer les secrets nécessaires juste à temps pour le déploiement.

## Utilisation

1. Copiez le contenu de ce répertoire à la racine de votre projet Keycloak.
2. Configurez les variables CI/CD nécessaires dans votre projet GitLab (ex: URL Vault, rôle Vault, variables d'environnement cibles).
3. Poussez vos modifications sur la branche `main` pour déclencher le pipeline complet.
