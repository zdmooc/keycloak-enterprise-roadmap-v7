# Cloud Terraform — historical reference

**Status: REFERENCE / REQUALIFICATION_REQUIRED**

This directory contains historical AWS/GCP/Azure infrastructure examples for Keycloak.

It must not be described as current production-ready IaC.

Before real use, requalify:
- cloud/Kubernetes versions;
- Terraform providers/modules;
- managed PostgreSQL versions;
- network/security defaults;
- private/public API exposure;
- state/backend/encryption;
- secret-manager integration;
- cost/HA assumptions;
- Keycloak Operator/runtime installation.

Do not place passwords in `terraform.tfvars` examples committed to Git.

Generic managed-cluster provisioning belongs primarily to `k8s-openshift-cluster-factory`; keep only Keycloak-specific architecture/integration value here.
