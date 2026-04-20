# Auteur : Zidane Djamal
# Description : Variables Terraform pour le déploiement GCP de Keycloak

variable "project_id" {
  description = "Identifiant du projet GCP"
  type        = string
}

variable "region" {
  description = "Région GCP cible"
  type        = string
  default     = "europe-west1"
}

variable "cluster_name" {
  description = "Nom du cluster GKE et préfixe des ressources"
  type        = string
  default     = "keycloak-gke-prod"
}

variable "subnet_cidr" {
  description = "CIDR du sous-réseau principal"
  type        = string
  default     = "10.0.0.0/24"
}

variable "node_count" {
  description = "Nombre de nœuds dans le node pool GKE"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "Type de machine GCE pour les nœuds GKE"
  type        = string
  default     = "e2-standard-4"
}

variable "db_tier" {
  description = "Tier de l'instance Cloud SQL"
  type        = string
  default     = "db-custom-2-7680"
}

variable "db_password" {
  description = "Mot de passe de l'utilisateur PostgreSQL"
  type        = string
  sensitive   = true
}
