# Déploiement Keycloak avec Ansible (Bare-Metal / VMs)

> **Auteur** : Zidane Djamal - Expert IAM / DevOps  
> **Contexte** : Ce répertoire fournit une collection de rôles Ansible pour préparer et déployer Keycloak sur des machines virtuelles ou des serveurs physiques, particulièrement adapté aux environnements RedHat/CentOS/Rocky Linux.

## Objectif

Bien que Keycloak soit de plus en plus déployé sur Kubernetes, de nombreuses entreprises exigent encore un déploiement sur des machines virtuelles (IaaS) pour des raisons de conformité, de contrôle réseau, ou de compétences internes.

Ces rôles Ansible permettent de :
1. Préparer l'OS (Firewall, SELinux, dépendances Java).
2. Installer et configurer PostgreSQL.
3. Télécharger, installer et configurer Keycloak en mode cluster (JGroups).
4. Gérer les services Systemd pour le démarrage automatique.

## Structure des Rôles

- `keycloak-prereqs` : Installation de Java (OpenJDK 17), configuration du pare-feu (firewalld) et tuning système.
- `keycloak-install` : Téléchargement de l'archive Keycloak, création de l'utilisateur système `keycloak`, extraction et gestion des droits.
- `keycloak-config` : Configuration du fichier `keycloak.conf`, génération des certificats TLS (ou intégration Vault), et configuration du service systemd.

## Prérequis

1. **Ansible** (v2.14+).
2. Des nœuds cibles sous **RHEL 8/9, Rocky Linux, AlmaLinux ou CentOS**.
3. Un accès SSH avec privilèges `sudo` (become).

## Démarrage Rapide

1. Adaptez l'inventaire `inventories/prod/hosts.ini` avec vos adresses IP :
   ```ini
   [keycloak_nodes]
   kc-node-01 ansible_host=10.0.1.11
   kc-node-02 ansible_host=10.0.1.12

   [db_nodes]
   db-node-01 ansible_host=10.0.1.20
   ```

2. Adaptez les variables dans `group_vars/all.yml` :
   ```yaml
   keycloak_version: "26.1.0"
   keycloak_admin_user: "admin"
   keycloak_admin_password: "SuperSecretPassword!"
   ```

3. Exécutez le playbook principal :
   ```bash
   ansible-playbook -i inventories/prod/hosts.ini site.yml -b
   ```

## Pourquoi Ansible pour Keycloak ?

Ansible brille particulièrement pour :
- **Le Rolling Restart** : Redémarrer les nœuds Keycloak un par un sans interruption de service.
- **La préparation des VMs** : Avant même que Keycloak ne tourne, l'OS doit être durci.
- **Les environnements "Air-Gapped"** : Ansible peut pousser les binaires et dépendances sans nécessiter d'accès internet sur les nœuds cibles.
