# Claim / Evidence Matrix

**Date:** 2026-10-01  
**Status:** O6 COMPLETE

| Capability | Evidence level | Evidence |
|---|---|---|
| IAM/OIDC/OAuth2/SAML corpus | STATIC_VALIDATED | specialist CI |
| Keycloak ownership / governance | STATIC_VALIDATED | O6 docs |
| GitOps Keycloak contract | STATIC_VALIDATED | specialist CI |
| Keycloak CR v2beta1 reference | STATIC_VALIDATED | specialist CI |
| Secret/token hygiene on active surfaces | STATIC_VALIDATED | specialist CI |
| Keycloak 26.8 container readiness | CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK | run 36877375874 |
| Metrics endpoint | CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK | run 36877375874 |
| OIDC discovery | CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK | run 36877375874 |
| Admin API realm/client/user lifecycle | CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK | run 36877375874 |
| client_credentials token issuance | CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK | run 36877375874 |
| restart persistence | CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK | run 36877375874 |
| post-restart token issuance | CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK | run 36877375874 |
| Scenario 01 secret-safe config | STATIC_VALIDATED | specialist CI |
| Current CRC/RHBK execution | NOT_PROVEN | local execution gate exists |
| LDAP/AD federation runtime | REFERENCE | NOT_RUNTIME_PROVEN |
| Identity brokering runtime | REFERENCE | NOT_RUNTIME_PROVEN |
| WebAuthn/passkeys runtime | REFERENCE | NOT_RUNTIME_PROVEN |
| Multi-cluster v2 failure behavior | REFERENCE | NOT_RUNTIME_PROVEN |
| Multi-site DR | REFERENCE | NOT_RUNTIME_PROVEN |
| Production | NOT_CLAIMED | — |

## Static evidence

Keycloak Specialist CI:
- baseline run `36877706958` — **SUCCESS**;
- final closeout run before P0 synchronization `36878286683` — **SUCCESS**;
- closeout commit `a00afa635ad4a2e067f3b67bae29948d7662af5c`.

Validated:
- active YAML/JSON structure;
- no token-response JSON artifacts on current main;
- no JWT/private-key material detected;
- no versioned Kubernetes Secret object in active surfaces;
- no stale V3/example.invalid GitOps references in active surfaces;
- active bootstrap variables are current;
- active Keycloak CRs use `v2beta1`;
- Kustomize rendering;
- Docker Compose configuration;
- shell syntax;
- native Kubernetes schema validation.

## Runtime evidence

Keycloak Runtime Proof:
- run `36877375874` — **SUCCESS**;
- commit `ca7c45144a7cb56b5bc17f876e37759349d05d74`;
- image `quay.io/keycloak/keycloak:26.8.0`.

Observed markers:

```text
KEYCLOAK_CONTAINER_READY=PASS
KEYCLOAK_METRICS=PASS
KEYCLOAK_OIDC_DISCOVERY=PASS
KEYCLOAK_ADMIN_API_REALM_CREATE=PASS
KEYCLOAK_ADMIN_API_CLIENT_USER=PASS
KEYCLOAK_CLIENT_CREDENTIALS_TOKEN=PASS
KEYCLOAK_RESTART_PERSISTENCE=PASS
KEYCLOAK_POST_RESTART_TOKEN=PASS
CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK=PASS
openshift_crc_claim=NOT_PROVEN
```

## Historical credential boundary

Generated localhost-lab access/refresh token files were removed from the current `main` tree during O6.

They are **not erased from Git history** by that deletion.

No historical token value is used as evidence or reproduced in this repository's O6 documentation.

## CRC / OpenShift boundary

Current CRC/RHBK execution remains `NOT_PROVEN`.

Only a fresh observed OpenShift execution may promote that level.

Execution template: `platform/crc/EVIDENCE_TEMPLATE.md`.
