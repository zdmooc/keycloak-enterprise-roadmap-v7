# Auteur : Zidane Djamal
# Description : Configuration Keycloak via le provider Terraform (Realm as Code).
# Ce fichier configure automatiquement un realm de démonstration, des clients et des rôles.
# Prérequis : Keycloak doit être déployé et accessible à l'URL définie dans les variables.

terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "~> 4.0"
    }
  }
}

provider "keycloak" {
  client_id = "admin-cli"
  username  = var.keycloak_admin_user
  password  = var.keycloak_admin_password
  url       = var.keycloak_url
}

# --- 1. Création du Realm de production ---
resource "keycloak_realm" "enterprise" {
  realm                    = "enterprise"
  enabled                  = true
  display_name             = "Entreprise SSO"
  display_name_html        = "<b>Entreprise SSO</b>"

  # Politique de mots de passe
  password_policy          = "length(12) and upperCase(1) and lowerCase(1) and digits(1) and specialChars(1)"

  # Durée de vie des tokens
  access_token_lifespan    = "15m"
  sso_session_idle_timeout = "30m"
  sso_session_max_lifespan = "10h"

  # Sécurité des mots de passe
  login_with_email_allowed  = true
  duplicate_emails_allowed  = false
  reset_password_allowed    = true
  remember_me               = false
  registration_allowed      = false
  edit_username_allowed     = false

  # Brute force protection
  brute_force_protected    = true
  permanent_lockout        = false
  max_failure_wait_seconds = 900
  minimum_quick_login_wait_seconds = 60
  wait_increment_seconds   = 60
  quick_login_check_milli_seconds = 1000
  max_delta_time_seconds   = 43200
  failure_factor           = 30
}

# --- 2. Rôles du Realm ---
resource "keycloak_role" "realm_admin" {
  realm_id    = keycloak_realm.enterprise.id
  name        = "realm-admin"
  description = "Administrateur du realm enterprise"
}

resource "keycloak_role" "app_user" {
  realm_id    = keycloak_realm.enterprise.id
  name        = "app-user"
  description = "Utilisateur applicatif standard"
}

resource "keycloak_role" "app_readonly" {
  realm_id    = keycloak_realm.enterprise.id
  name        = "app-readonly"
  description = "Accès en lecture seule aux applications"
}

# --- 3. Client Confidentiel (Backend API / Resource Server) ---
resource "keycloak_openid_client" "backend_api" {
  realm_id              = keycloak_realm.enterprise.id
  client_id             = "backend-api"
  name                  = "Backend API"
  enabled               = true
  access_type           = "CONFIDENTIAL"
  standard_flow_enabled = false
  service_accounts_enabled = true

  # Durée de vie des tokens spécifique à ce client
  access_token_lifespan = "5m"
}

# --- 4. Client Public (SPA Frontend) ---
resource "keycloak_openid_client" "spa_frontend" {
  realm_id                     = keycloak_realm.enterprise.id
  client_id                    = "spa-frontend"
  name                         = "SPA Frontend"
  enabled                      = true
  access_type                  = "PUBLIC"
  standard_flow_enabled        = true
  pkce_code_challenge_method   = "S256"

  valid_redirect_uris = [
    "https://app.example.com/*",
    "http://localhost:3000/*",
  ]

  web_origins = [
    "https://app.example.com",
    "http://localhost:3000",
  ]
}

# --- 5. Groupe d'utilisateurs ---
resource "keycloak_group" "developers" {
  realm_id = keycloak_realm.enterprise.id
  name     = "developers"
}

resource "keycloak_group_roles" "developers_roles" {
  realm_id = keycloak_realm.enterprise.id
  group_id = keycloak_group.developers.id

  role_ids = [
    keycloak_role.app_user.id,
  ]
}
