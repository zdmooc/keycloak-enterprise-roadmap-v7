# O6 Fresh CRC / RHBK Evidence Gate

**Current status:** NOT_PROVEN

## Preconditions

- CRC/OpenShift Local running;
- authenticated `oc`;
- sufficient resources;
- RHBK Operator available in the configured catalog;
- local runtime DB credentials exported.

## Execute

```bash
export KC_DB_USERNAME=keycloak
export KC_DB_PASSWORD='<runtime-only-secret>'
bash install/01-crc-local/scripts/deploy-keycloak-crc.sh
```

## Capture

Store sanitized evidence for:
- date;
- Git commit;
- `oc version`;
- ClusterVersion;
- RHBK Operator CSV/channel/version;
- Keycloak CR apiVersion/status;
- pods;
- services/routes/ingress;
- health;
- metrics;
- OIDC discovery;
- generated initial-admin Secret name only — never its value.

## Day-2 promotion

For a stronger claim also execute and capture:
- pod restart;
- Keycloak restart/reconciliation;
- PostgreSQL restart;
- realm persistence;
- token issuance after restart;
- backup/restore if tested;
- Operator/Keycloak upgrade if tested.

## Promotion rule

Do not write `CRC_RUNTIME_PROVEN_KEYCLOAK` until the corresponding behavior is observed and evidence is stored.

Container CI evidence cannot substitute for OpenShift/RHBK evidence.
