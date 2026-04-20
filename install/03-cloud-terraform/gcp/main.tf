# Auteur : Zidane Djamal
# Description : Configuration principale Terraform pour déployer l'infrastructure GCP pour Keycloak

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# --- 1. Activation des APIs GCP nécessaires ---
resource "google_project_service" "apis" {
  for_each = toset([
    "container.googleapis.com",
    "sqladmin.googleapis.com",
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
  ])
  service            = each.key
  disable_on_destroy = false
}

# --- 2. VPC et Sous-réseau ---
resource "google_compute_network" "keycloak_vpc" {
  name                    = "${var.cluster_name}-vpc"
  auto_create_subnetworks = false
  depends_on              = [google_project_service.apis]
}

resource "google_compute_subnetwork" "keycloak_subnet" {
  name          = "${var.cluster_name}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.keycloak_vpc.id

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.2.0.0/20"
  }
}

# --- 3. Cluster GKE (Autopilot ou Standard) ---
resource "google_container_cluster" "keycloak_gke" {
  name     = var.cluster_name
  location = var.region

  network    = google_compute_network.keycloak_vpc.name
  subnetwork = google_compute_subnetwork.keycloak_subnet.name

  # Supprimer le node pool par défaut et créer le nôtre
  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  depends_on = [google_project_service.apis]
}

resource "google_container_node_pool" "keycloak_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.keycloak_gke.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 50

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    labels = {
      env     = "production"
      project = "keycloak"
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

# --- 4. Cloud SQL PostgreSQL (HA) ---
resource "google_sql_database_instance" "keycloak_db" {
  name             = "${var.cluster_name}-db"
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    tier              = var.db_tier
    availability_type = "REGIONAL"  # HA Multi-zone

    backup_configuration {
      enabled                        = true
      start_time                     = "03:00"
      point_in_time_recovery_enabled = true
      transaction_log_retention_days = 7
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.keycloak_vpc.id
    }

    database_flags {
      name  = "max_connections"
      value = "200"
    }
  }

  deletion_protection = false
  depends_on          = [google_project_service.apis]
}

resource "google_sql_database" "keycloak" {
  name     = "keycloak"
  instance = google_sql_database_instance.keycloak_db.name
}

resource "google_sql_user" "keycloak" {
  name     = "keycloak"
  instance = google_sql_database_instance.keycloak_db.name
  password = var.db_password
}
