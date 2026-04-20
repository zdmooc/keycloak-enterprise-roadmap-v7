# Auteur : Zidane Djamal
# Description : Configuration principale Terraform pour déployer l'infrastructure Azure pour Keycloak

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
  }
}

provider "azurerm" {
  features {}
}

# --- 1. Resource Group ---
resource "azurerm_resource_group" "keycloak_rg" {
  name     = "${var.cluster_name}-rg"
  location = var.location

  tags = {
    Environment = "Production"
    Project     = "Keycloak"
  }
}

# --- 2. Virtual Network et Sous-réseaux ---
resource "azurerm_virtual_network" "keycloak_vnet" {
  name                = "${var.cluster_name}-vnet"
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.keycloak_rg.location
  resource_group_name = azurerm_resource_group.keycloak_rg.name
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.keycloak_rg.name
  virtual_network_name = azurerm_virtual_network.keycloak_vnet.name
  address_prefixes     = [var.aks_subnet_cidr]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = "db-subnet"
  resource_group_name  = azurerm_resource_group.keycloak_rg.name
  virtual_network_name = azurerm_virtual_network.keycloak_vnet.name
  address_prefixes     = [var.db_subnet_cidr]

  service_endpoints = ["Microsoft.Sql"]

  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# --- 3. Cluster AKS ---
resource "azurerm_kubernetes_cluster" "keycloak_aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.keycloak_rg.location
  resource_group_name = azurerm_resource_group.keycloak_rg.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name           = "keycloak"
    node_count     = var.node_count
    vm_size        = var.vm_size
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    Environment = "Production"
    Project     = "Keycloak"
  }
}

# --- 4. Azure Database for PostgreSQL Flexible Server ---
resource "azurerm_private_dns_zone" "postgres_dns" {
  name                = "${var.cluster_name}.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.keycloak_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres_dns_link" {
  name                  = "${var.cluster_name}-dns-link"
  private_dns_zone_name = azurerm_private_dns_zone.postgres_dns.name
  virtual_network_id    = azurerm_virtual_network.keycloak_vnet.id
  resource_group_name   = azurerm_resource_group.keycloak_rg.name
}

resource "azurerm_postgresql_flexible_server" "keycloak_db" {
  name                   = "${var.cluster_name}-db"
  resource_group_name    = azurerm_resource_group.keycloak_rg.name
  location               = azurerm_resource_group.keycloak_rg.location
  version                = "15"
  delegated_subnet_id    = azurerm_subnet.db_subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.postgres_dns.id
  administrator_login    = "keycloak"
  administrator_password = var.db_password
  zone                   = "1"

  high_availability {
    mode                      = "ZoneRedundant"
    standby_availability_zone = "2"
  }

  storage_mb = 32768

  sku_name   = var.db_sku
  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgres_dns_link]
}

resource "azurerm_postgresql_flexible_server_database" "keycloak" {
  name      = "keycloak"
  server_id = azurerm_postgresql_flexible_server.keycloak_db.id
  collation = "en_US.utf8"
  charset   = "utf8"
}
