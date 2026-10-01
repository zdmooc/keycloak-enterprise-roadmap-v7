# O6 Keycloak 26.8 Container Runtime Evidence

**Date:** 2026-10-01  
**Workflow:** Keycloak Runtime Proof  
**Run:** `36877375874`  
**Commit:** `ca7c45144a7cb56b5bc17f876e37759349d05d74`  
**Image:** `quay.io/keycloak/keycloak:26.8.0`  
**Result:** SUCCESS

## Executed path

```text
Keycloak 26.8.0
  -> health/readiness
  -> metrics
  -> OIDC discovery
  -> temporary bootstrap admin
  -> Admin API realm creation
  -> Admin API client creation
  -> Admin API user creation
  -> client_credentials token issuance
  -> container restart on same data volume
  -> realm still discoverable
  -> client_credentials token still issued
```

Credentials were generated at runtime and were not written into repository artifacts.

## Observed markers

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

## Allowed claim

`CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK`.

## Not proven

- current CRC/OpenShift/RHBK;
- PostgreSQL-backed Operator runtime;
- rolling upgrade;
- failover;
- LDAP/AD federation;
- identity brokering;
- passkeys;
- HA/multi-cluster;
- production.
