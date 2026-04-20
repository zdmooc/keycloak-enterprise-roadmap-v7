# Auteur : Zidane Djamal
# Description : Outputs Terraform pour le déploiement AWS de Keycloak

output "cluster_endpoint" {
  description = "Endpoint de l'API server du cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Nom du cluster EKS"
  value       = module.eks.cluster_name
}

output "db_endpoint" {
  description = "Endpoint de l'instance RDS PostgreSQL"
  value       = module.db.db_instance_endpoint
  sensitive   = true
}

output "vpc_id" {
  description = "Identifiant du VPC créé"
  value       = module.vpc.vpc_id
}

output "kubeconfig_command" {
  description = "Commande pour configurer kubectl avec le cluster EKS"
  value       = "aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name}"
}
