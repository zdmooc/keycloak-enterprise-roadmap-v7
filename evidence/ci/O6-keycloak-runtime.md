# O6 Keycloak 26.8 Runtime Evidence

**Date:** 2026-10-01  
**Workflow:** Keycloak Runtime Proof  
**Run:** `36877375874`  
**Commit:** `ca7c45144a7cb56b5bc17f876e37759349d05d74`  
**Image:** `quay.io/keycloak/keycloak:26.8.0`  
**Result:** SUCCESS

## Executed runtime

```text
Keycloak 26.8.0
  -> readiness endpoint
  -> metrics endpoint
  -> master OIDC discovery
  -> Admin API
       -> create realm o6-ci
       -> create service-account client
       -> create user alice
  -> client_credentials token issuance
  -> container restart on the same local data volume
  -> o6-ci realm still present
  -> client_credentials token still issuable
```

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

## Security properties of the proof

- bootstrap/admin/user/client credentials are generated at runtime;
- no token value is written to the repository;
- token responses are inspected in memory only;
- no password/token is printed as an evidence marker;
- the runtime container/volume are deleted by the CI cleanup path.

## Allowed claim

`CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK`.

## Not proven

- current CRC/OpenShift/RHBK runtime;
- Operator lifecycle;
- LDAP/AD federation;
- identity brokering;
- WebAuthn/passkeys;
- multi-cluster failure behavior;
- multi-site DR;
- production readiness.
