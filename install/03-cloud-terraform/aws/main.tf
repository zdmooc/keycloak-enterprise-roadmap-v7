# Auteur : Zidane Djamal
# Description : Configuration principale Terraform pour déployer l'infrastructure AWS pour Keycloak

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# --- 1. VPC et Réseau ---
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = "Production"
    Project     = "Keycloak"
  }
}

# --- 2. Cluster EKS ---
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.16.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    keycloak_nodes = {
      min_size     = 2
      max_size     = 5
      desired_size = 3
      instance_types = ["t3.medium"]
    }
  }

  tags = {
    Environment = "Production"
    Project     = "Keycloak"
  }
}

# --- 3. Base de données RDS PostgreSQL ---
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.1.1"

  identifier = "${var.cluster_name}-db"

  engine               = "postgres"
  engine_version       = "15.3"
  family               = "postgres15"
  major_engine_version = "15"
  instance_class       = "db.t3.medium"

  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = "keycloak"
  username = "keycloak"
  password = var.db_password
  port     = 5432

  multi_az               = true
  subnet_ids             = module.vpc.private_subnets
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 7

  tags = {
    Environment = "Production"
    Project     = "Keycloak"
  }
}

# --- 4. Security Group pour RDS ---
resource "aws_security_group" "db_sg" {
  name_prefix = "${var.cluster_name}-db-sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id]
  }

  tags = {
    Name = "${var.cluster_name}-db-sg"
  }
}
