# Auteur : Zidane Djamal
# Description : Variables Terraform pour le déploiement Azure de Keycloak

variable "location" {
  description = "Région Azure cible"
  type        = string
  default     = "West Europe"
}

variable "cluster_name" {
  description = "Nom du cluster AKS et préfixe des ressources"
  type        = string
  default     = "keycloak-aks-prod"
}

variable "vnet_cidr" {
  description = "CIDR du Virtual Network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "aks_subnet_cidr" {
  description = "CIDR du sous-réseau pour les nœuds AKS"
  type        = string
  default     = "10.0.1.0/24"
}

variable "db_subnet_cidr" {
  description = "CIDR du sous-réseau délégué pour PostgreSQL Flexible Server"
  type        = string
  default     = "10.0.2.0/24"
}

variable "node_count" {
  description = "Nombre de nœuds dans le pool AKS"
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "Taille des VMs pour les nœuds AKS"
  type        = string
  default     = "Standard_D4s_v3"
}

variable "db_sku" {
  description = "SKU de l'instance PostgreSQL Flexible Server"
  type        = string
  default     = "GP_Standard_D2s_v3"
}

variable "db_password" {
  description = "Mot de passe de l'administrateur PostgreSQL"
  type        = string
  sensitive   = true
}
