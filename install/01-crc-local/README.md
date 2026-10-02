# Keycloak / RHBK on OpenShift Local

## Role

Active **CRC/OpenShift lab contract** for Red Hat Build of Keycloak through OperatorHub.

It is a lab contract. This exact deployment path was reused by `shared-platform-services-openshift` during the observed CRC 4.22.7 shared-identity bootstrap on 2026-10-02.

## Secret model

No database or admin password is stored in Git.

Before running:

```bash
export KC_DB_USERNAME=keycloak
export KC_DB_PASSWORD='<local-runtime-secret>'
bash scripts/deploy-keycloak-crc.sh
```

The script creates `keycloak-db-secret` at runtime.

The Operator generates the initial admin Secret when no explicit bootstrap admin is supplied. Retrieve it only when needed and never commit the value.

## Flow

```text
namespace
 -> RHBK Operator subscription
 -> runtime DB Secret
 -> PostgreSQL lab DB
 -> Keycloak CR v2beta1
 -> Ready
 -> Route/Ingress verification
```

## Evidence required for promotion

Capture:
- `oc version`;
- installed CSV/operator version;
- Keycloak CR status;
- pods;
- route/ingress;
- health/metrics;
- OIDC discovery;
- restart/upgrade result if tested.

Observed bounded claim after the 2026-10-02 shared-platform execution:
`CRC_SHARED_IDENTITY_BOOTSTRAP_PROVEN`.

This covers deployment readiness + shared realm/OIDC discovery only. Full specialist CRC evidence still requires the broader checks listed in `platform/crc/EVIDENCE_TEMPLATE.md`.
