# CRC / RHBK Keycloak Evidence Template

**Purpose:** promote the Keycloak specialist baseline from implementation/static evidence to an observed OpenShift Local / Red Hat Build of Keycloak runtime claim.

## Metadata

- Date:
- Git commit:
- CRC/OpenShift version:
- RHBK Operator CSV/version:
- Keycloak CR apiVersion:
- Keycloak CR name:
- Namespace:

## Preflight

Capture sanitized output for:

```bash
oc whoami
oc whoami --show-server
oc get clusterversion version -o wide
oc get clusteroperators
oc get nodes -o wide
```

Expected:
- target cluster is the intended CRC/OpenShift Local;
- cluster operators used by the lab are healthy.

## Operator

Capture:

```bash
oc -n keycloak-system get subscription,csv
oc -n keycloak-system get pods -o wide
```

Record:
- Operator name/version:
- CSV phase:
- Operator pod Ready:

## Keycloak

Capture:

```bash
oc -n keycloak-system get keycloak keycloak -o yaml
oc -n keycloak-system get pods,svc,route,ingress -o wide
```

Record:
- CR Ready:
- Keycloak pod(s) Ready:
- exposed URL:
- number of instances observed:

## Security boundary

Do **not** store:
- bootstrap-admin password;
- database password;
- access/refresh/ID tokens;
- kubeconfig;
- cookies;
- private keys.

If the Operator created `keycloak-initial-admin`, record only that the Secret exists.

## Protocol/runtime validation

Required observations:

- health/readiness works;
- metrics works if enabled;
- OIDC discovery works;
- realm creation/availability works;
- client configuration works;
- token issuance works without persisting token values;
- restart of Keycloak pod(s) does not lose expected realm/config state.

Record markers:

```text
CRC_RHBK_OPERATOR_READY=
CRC_KEYCLOAK_CR_READY=
CRC_KEYCLOAK_OIDC_DISCOVERY=
CRC_KEYCLOAK_TOKEN_ISSUANCE=
CRC_KEYCLOAK_RESTART_PERSISTENCE=
```

## GitOps optional promotion

If deployed through OpenShift GitOps, also capture:
- Application Sync status;
- Application Health;
- source Git revision.

## Claim promotion

Only if the specific tests above are observed may the corresponding matrix rows be promoted to:

`CRC_RUNTIME_PROVEN_KEYCLOAK`.

This still does not prove:
- multi-node HA;
- zone/site failure tolerance;
- multi-cluster DR;
- production readiness.
