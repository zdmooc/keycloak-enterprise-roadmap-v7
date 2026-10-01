# Current Keycloak baseline — 2026-10-01

## Upstream

Reference baseline for this repository:

- Keycloak upstream: **26.8.0**;
- release date: 2026-10-01;
- container examples: `quay.io/keycloak/keycloak:26.8.0`;
- Kubernetes Operator install reference: `github.com/keycloak/keycloak-k8s-resources/kubernetes?ref=26.8.0`;
- current Keycloak CR examples use `k8s.keycloak.org/v2beta1`.

## Red Hat Build of Keycloak

OpenShift/RHBK examples are tracked separately from upstream.

The repository does not assume that an upstream patch/minor number is automatically the matching supported Red Hat build.

The CRC lab currently targets the RHBK 26 channel through OperatorHub and uses the CRD maturity recommended by current RHBK 26.x documentation.

## Important 26.8 architecture change

Keycloak 26.8 promotes **multi-cluster v2 / stateless mode** to supported.

The older multi-cluster v1 / `multi-site` direction is deprecated upstream.

Therefore:
- new multi-cluster studies should evaluate v2/stateless first;
- old multi-site v1 material is historical/migration context;
- no HA/DR claim is made until latency, DB, failure and recovery tests are observed.

## Admin bootstrap

For current server/container examples use:
- `KC_BOOTSTRAP_ADMIN_USERNAME`;
- `KC_BOOTSTRAP_ADMIN_PASSWORD`.

The older `KEYCLOAK_ADMIN` variables are deprecated.

With the current Operator, omitting an explicit bootstrap admin lets the Operator generate the initial admin Secret.

## Production boundary

`start-dev`, HTTP-only hostnames, embedded H2 and demo credentials are local-learning tools only.

Production requires explicit TLS/hostname, external supported DB, secret delivery, admin-plane exposure decisions, monitoring, upgrade compatibility and tested HA/DR.
