# Argo CD — Keycloak specialist contract

Generic Argo CD mechanics belong to `zdmooc/argocd-expert-pack`.

This directory keeps only the **Keycloak-specific consumption example**.

## Active files

- `project.yaml` — bounded AppProject for the Keycloak reference;
- `application.yaml` — one Application pointing to this repository's Keycloak manifests.

## OpenShift convention

Argo CD resources use namespace:
`openshift-gitops`.

## Secret rule

The GitOps Application does not carry database/admin credentials.

Required secrets are created by the platform secret-delivery mechanism before Keycloak becomes Ready.

## Evidence

A valid Application manifest is static evidence only.

`Synced/Healthy` on OpenShift must be observed separately.
