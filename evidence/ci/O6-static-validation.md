# O6 Static / Security Validation Evidence

**Date:** 2026-10-01  
**Workflow:** Keycloak Specialist CI  
**Run:** `36877706958`  
**Commit:** `86319cfeadc7af57fe4b9618b91d22dc0c347ca8`  
**Result:** SUCCESS

## Validated

- active Keycloak YAML and JSON;
- no token-response artifacts on current main;
- JWT/private-key scan;
- no versioned Kubernetes Secret in active surfaces;
- current GitOps repository/namespace contract;
- no active `v2alpha1` Keycloak CR;
- no active Keycloak 26.1 image pin;
- no deprecated bootstrap-admin variables in active surfaces;
- Kustomize render;
- Compose render for local lab and scenario 01;
- shell syntax;
- kubeconform for rendered native Kubernetes resources.

## Boundary

Terraform cloud, Ansible VM/bare-metal and incomplete Scenario 02 are explicitly classified as reference/requalification surfaces and are not promoted by this CI.
