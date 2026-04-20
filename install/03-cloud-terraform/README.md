# Déploiement Keycloak sur le Cloud avec Terraform

> **Auteur** : Zidane Djamal - Expert IAM / DevOps  
> **Contexte** : Ce répertoire contient les modules Terraform (IaC) pour déployer une infrastructure Keycloak complète et prête pour la production sur les trois principaux fournisseurs Cloud : AWS, GCP et Azure.

## Objectif

L'objectif est de fournir une infrastructure as code (IaC) standardisée, sécurisée et hautement disponible pour Keycloak.

L'architecture cible déployée par ces modules comprend :
1. **Réseau** : VPC/VNet dédié avec sous-réseaux publics (pour les Load Balancers) et privés (pour les nœuds Kubernetes et la base de données).
2. **Base de données managée** : Instance PostgreSQL managée (Amazon RDS, Google Cloud SQL, Azure Database for PostgreSQL) pour une haute disponibilité et des sauvegardes automatiques.
3. **Cluster Kubernetes managé** : Cluster Kubernetes (EKS, GKE, AKS) pour héberger l'Operator Keycloak et les pods Keycloak.
4. **Configuration Keycloak** : Utilisation du provider Terraform `mrparkers/keycloak` pour configurer automatiquement le realm initial, les clients et les rôles.

## Structure du Répertoire

```text
03-cloud-terraform/
├── aws/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/
│       ├── vpc/
│       ├── eks/
│       └── rds/
├── gcp/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/
│       ├── vpc/
│       ├── gke/
│       └── cloudsql/
├── azure/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/
│       ├── vnet/
│       ├── aks/
│       └── postgres/
└── shared/
    ├── keycloak-config.tf
    └── variables.tf
```

## Prérequis Communs

1. **Terraform** installé (v1.5+).
2. CLI du fournisseur Cloud (`aws-cli`, `gcloud`, ou `az`).
3. Droits d'administration sur le compte/projet Cloud cible.

## Déploiement AWS (Exemple)

```bash
cd aws

# Initialiser Terraform
terraform init

# Créer un fichier terraform.tfvars avec vos variables
cat <<EOF > terraform.tfvars
region         = "eu-west-3"
cluster_name   = "keycloak-eks-prod"
db_password    = "ChangeMe123!"
keycloak_admin = "admin"
keycloak_pass  = "adminadmin"
EOF

# Planifier le déploiement
terraform plan

# Appliquer (Attention: des coûts seront engendrés)
terraform apply
```

## Configuration de Keycloak via Terraform

Le dossier `shared/` contient la configuration interne de Keycloak (Realm as Code). Une fois l'infrastructure (EKS/GKE/AKS + DB) déployée et Keycloak installé sur le cluster, vous pouvez appliquer la configuration :

```bash
cd shared

# Configurer le provider avec l'URL de votre Ingress/LoadBalancer
cat <<EOF > terraform.tfvars
keycloak_url   = "https://keycloak.votre-domaine.com"
client_id      = "admin-cli"
username       = "admin"
password       = "adminadmin"
EOF

terraform init
terraform apply
```

## Sécurité et Bonnes Pratiques

- **Secrets** : Ne commitez jamais les fichiers `terraform.tfvars`. Utilisez un gestionnaire de secrets (comme HashiCorp Vault, AWS Secrets Manager) en production.
- **State** : Configurez un backend distant (S3, GCS, Azure Blob Storage) pour stocker le fichier d'état `terraform.tfstate`.
- **Réseau** : Les bases de données ne sont accessibles que depuis le réseau privé du cluster Kubernetes.
