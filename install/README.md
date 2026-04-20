# Installation et Déploiement de Keycloak

> **Auteur** : Zidane Djamal - Expert IAM / DevOps  
> **Dernière mise à jour** : Avril 2026

Ce répertoire centralise toutes les méthodes d'installation et de déploiement de Keycloak, des environnements locaux de développement jusqu'aux infrastructures Cloud de production.

## Vue d'Ensemble des Méthodes

| Méthode | Environnement | Outil Principal | Cas d'Usage |
| :--- | :--- | :--- | :--- |
| `01-crc-local/` | Local (OpenShift) | OC CLI + Operator | Développement, test sur OpenShift |
| `02-kind-local/` | Local (Kubernetes) | Kind + kubectl | Développement, test sur Kubernetes pur |
| `03-cloud-terraform/` | AWS / GCP / Azure | Terraform | Production Cloud |
| `04-ansible/` | VMs / Bare-Metal | Ansible | Production sur RHEL/Rocky Linux |
| `05-cicd-gitlab/` | Tous environnements | GitLab CI/CD | Automatisation CI/CD, Realm as Code |

## Parcours Recommandé

Le parcours d'apprentissage recommandé suit une progression logique, du plus simple au plus complexe :

**Étape 1 — Maîtriser l'environnement local Kubernetes (Kind)**  
Commencez par `02-kind-local/` si vous êtes familier avec Docker et Kubernetes standard. C'est le point d'entrée le plus accessible pour comprendre le déploiement de l'Operator Keycloak.

**Étape 2 — Maîtriser l'environnement local OpenShift (CRC)**  
Passez ensuite à `01-crc-local/` pour comprendre les spécificités d'OpenShift (Routes, OperatorHub, RHBK). C'est indispensable pour les environnements d'entreprise utilisant Red Hat.

**Étape 3 — Automatiser avec Ansible (VMs)**  
Explorez `04-ansible/` pour comprendre comment déployer Keycloak sur des VMs RHEL, ce qui reste courant dans les environnements d'entreprise traditionnels ou les environnements "air-gapped".

**Étape 4 — Déployer sur le Cloud avec Terraform**  
Abordez `03-cloud-terraform/` pour maîtriser le déploiement d'une infrastructure complète (réseau, base de données managée, cluster Kubernetes managé) sur AWS, GCP ou Azure.

**Étape 5 — Industrialiser avec CI/CD**  
Finalisez avec `05-cicd-gitlab/` pour comprendre comment automatiser l'ensemble du cycle de vie (Realm as Code, tests, promotion d'environnement, intégration Vault).

## Prérequis Communs

Quel que soit l'environnement cible, les prérequis suivants sont recommandés :
- Lecture préalable du parcours `docs/learning-path.md` (niveaux 0 à 4 minimum).
- Compréhension des protocoles OIDC et OAuth2 (`docs/01-fundamentals/`).
- Familiarité avec les concepts de base de Kubernetes (Pods, Services, Secrets, ConfigMaps).
