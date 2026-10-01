# O6 — Keycloak Enterprise Roadmap hardening

**Date:** 2026-10-01

## Goal

Transform this repository into the canonical **Keycloak / IAM specialist repository** of the OpenShift portfolio without duplicating the common platform repository.

## Starting findings

- public repository;
- generated access/refresh token JSON files were committed under `labs-local/`;
- several Kubernetes Secret examples contain fixed local credentials, including base64 values;
- GitOps manifests still reference `keycloak-enterprise-roadmap-v3`, `example.invalid`, namespace `argocd`, and project `default`;
- some runtime manifests pin old Keycloak examples;
- no GitHub Actions CI exists;
- evidence directories mostly contain placeholders rather than observed runtime proof.

## Ownership

This repository owns:
- IAM/OIDC/OAuth2/SAML design;
- Keycloak realm/client/role/group architecture;
- Keycloak security hardening;
- identity brokering and LDAP/AD integration patterns;
- Keycloak Operator/CR patterns;
- Keycloak-specific HA, upgrade, backup/restore and SRE;
- integration patterns;
- Keycloak-specific tests and evidence.

It consumes:
- cluster lifecycle from `k8s-openshift-cluster-factory`;
- shared-platform service contract from `shared-platform-services-openshift`;
- GitOps specialist patterns from `argocd-expert-pack`.

## Iterations

### O6-I1 — Secret/token truth
- remove generated tokens/runtime artifacts from main;
- strengthen ignore rules;
- document historical exposure boundary;
- establish ownership/evidence vocabulary.

### O6-I2 — GitOps cleanup
- remove stale V3/example.invalid references;
- use OpenShift GitOps conventions;
- separate specialist reference manifests from shared-platform ownership.

### O6-I3 — Secret delivery
- remove fixed base64/password Secret manifests from active surfaces;
- use templates/scripts/env or secret-provider contracts;
- scan for JWT/private-key/token/credential leakage.

### O6-I4 — Version and architecture refresh
- refresh upstream Keycloak baseline;
- separate upstream Keycloak from Red Hat Build of Keycloak;
- update HA roadmap for current multi-cluster/stateless direction;
- retain version pinning only where a tested lab requires it.

### O6-I5 — CI
- YAML/JSON validation;
- Kustomize rendering;
- shell/Terraform/Ansible syntax where practical;
- GitOps repository/path checks;
- secret/JWT/private-key detection;
- documentation boundary checks.

### O6-I6 — Runtime / Day-2
- container smoke: discovery, health, admin bootstrap hygiene;
- controlled realm/client/user lifecycle;
- token issuance without persisting token values;
- restart/health evidence;
- OpenShift/CRC gate documented separately.

### O6-I7 — Closure
- claim/evidence matrix;
- completion record;
- P0 synchronization.

## Evidence vocabulary

- `REFERENCE`
- `IMPLEMENTED`
- `STATIC_VALIDATED`
- `CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK`
- `HISTORICAL_LOCAL_EVIDENCE`
- `CRC_RUNTIME_PROVEN_KEYCLOAK`
- `PRODUCTION_REFERENCE`

No documentation or manifest is promoted to production evidence.


## Completion

O6 completed on 2026-10-01.

Observed evidence:
- static/security closeout CI: `36878286683` SUCCESS on `a00afa635ad4a2e067f3b67bae29948d7662af5c`;
- Keycloak 26.8.0 runtime: `36877375874` SUCCESS;
- readiness, metrics, OIDC discovery, Admin API lifecycle, client credentials token, restart persistence and post-restart token issuance observed.

Current CRC/RHBK remains a separate `NOT_PROVEN` environment promotion gate.
