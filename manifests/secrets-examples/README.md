# Secret delivery examples

No real or fixed credential Secret is versioned here.

## Local lab

Create the database Secret from runtime environment variables:

```bash
: "${KC_DB_USERNAME:?set KC_DB_USERNAME}"
: "${KC_DB_PASSWORD:?set KC_DB_PASSWORD}"

kubectl -n keycloak create secret generic keycloak-db-secret \
  --from-literal=username="$KC_DB_USERNAME" \
  --from-literal=password="$KC_DB_PASSWORD" \
  --dry-run=client -o yaml | kubectl apply -f -
```

## OpenShift / enterprise

Prefer the platform-approved secret delivery mechanism, for example an external secret manager/operator.

The Keycloak CR should only reference Secret names/keys; it must not embed credential values.

## Bootstrap admin

With the current Keycloak Operator, if no explicit `spec.bootstrapAdmin` is configured, the Operator generates an initial admin Secret named `<keycloak-cr-name>-initial-admin`.

Treat that credential as temporary and rotate/replace it according to the environment security policy.
