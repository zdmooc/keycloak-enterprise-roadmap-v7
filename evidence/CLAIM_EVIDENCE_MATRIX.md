# Claim / Evidence Matrix

**Date:** 2026-10-01  
**Status:** O6 IN PROGRESS

| Capability | Evidence |
|---|---|
| IAM/OIDC/SAML documentation | IMPLEMENTED |
| Keycloak architecture docs | IMPLEMENTED |
| Local V7 scenario | HISTORICAL_LOCAL_EVIDENCE / REQUALIFICATION_REQUIRED |
| Generated token storage | REMOVED_FROM_MAIN |
| Secret hygiene | IN_PROGRESS |
| GitOps Keycloak manifests | STALE / REPAIR_REQUIRED |
| Keycloak Operator manifests | IMPLEMENTED / REQUALIFICATION_REQUIRED |
| Container runtime smoke | NOT_PROVEN_CURRENT_O6 |
| OpenShift/CRC runtime | NOT_PROVEN_CURRENT_O6 |
| Multi-node HA | NOT_PROVEN |
| Multi-site DR | REFERENCE |
| Production | NOT_CLAIMED |

## Historical token boundary

Generated OAuth token files were found on the public repository and removed from current `main`.

They remain part of historical Git objects unless history is separately rewritten.

No token value is used as evidence.

## Current evidence rule

Only observed, repeatable results created by O6 CI/runtime may be promoted.
