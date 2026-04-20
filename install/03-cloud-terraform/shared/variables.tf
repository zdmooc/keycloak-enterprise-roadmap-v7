# Auteur : Zidane Djamal
# Description : Variables pour la configuration Keycloak via le provider Terraform

variable "keycloak_url" {
  description = "URL d'accès à l'instance Keycloak (ex: https://keycloak.example.com)"
  type        = string
}

variable "keycloak_admin_user" {
  description = "Nom d'utilisateur de l'administrateur Keycloak"
  type        = string
  default     = "admin"
}

variable "keycloak_admin_password" {
  description = "Mot de passe de l'administrateur Keycloak"
  type        = string
  sensitive   = true
}
