# Auteur : Zidane Djamal
# Description : Variables Terraform pour le déploiement AWS de Keycloak

variable "region" {
  description = "Région AWS cible pour le déploiement"
  type        = string
  default     = "eu-west-3"
}

variable "cluster_name" {
  description = "Nom du cluster EKS et préfixe des ressources associées"
  type        = string
  default     = "keycloak-eks-prod"
}

variable "vpc_cidr" {
  description = "CIDR du VPC dédié à Keycloak"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Zones de disponibilité à utiliser pour la haute disponibilité"
  type        = list(string)
  default     = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
}

variable "private_subnets" {
  description = "CIDRs des sous-réseaux privés (nœuds EKS, base de données)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "CIDRs des sous-réseaux publics (Load Balancers)"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "db_password" {
  description = "Mot de passe de la base de données PostgreSQL (RDS)"
  type        = string
  sensitive   = true
}

variable "keycloak_admin" {
  description = "Nom d'utilisateur de l'administrateur Keycloak initial"
  type        = string
  default     = "admin"
}

variable "keycloak_pass" {
  description = "Mot de passe de l'administrateur Keycloak initial"
  type        = string
  sensitive   = true
}
