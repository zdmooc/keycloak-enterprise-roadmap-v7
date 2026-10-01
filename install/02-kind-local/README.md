# Keycloak Operator on Kind

## Role

Active upstream Kubernetes lab using the official Keycloak Operator.

Default pinned upstream version:
`26.8.0`.

## Run

```bash
export KC_DB_USERNAME=keycloak
export KC_DB_PASSWORD='<local-runtime-secret>'
bash scripts/deploy-keycloak-kind.sh
```

The script:
- creates/reuses Kind;
- installs the official Operator through the upstream Kustomize package;
- creates the DB Secret at runtime;
- deploys the PostgreSQL lab DB;
- deploys a `v2beta1` Keycloak CR;
- does not print admin credentials.

The initial admin Secret is Operator-generated.

## Boundary

This lab is separate from the lightweight container runtime proof in CI.

It is not production or HA evidence.
