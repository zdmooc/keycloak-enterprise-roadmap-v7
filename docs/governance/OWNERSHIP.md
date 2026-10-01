# Keycloak / IAM ownership

## Canonical responsibility

`keycloak-enterprise-roadmap-v7` is the portfolio's **deep Keycloak/IAM specialist repository**.

It owns the Keycloak-specific depth that should not be copied into the common platform repository.

## Relationship to Shared Platform Services

`shared-platform-services-openshift` owns the common-platform **service contract**:
- consumers need an OIDC issuer;
- discovery must be reachable;
- platform tenancy and integration boundaries exist.

This repository owns the implementation/design depth:
- realms and clients;
- groups/roles/scopes;
- authentication flows;
- brokering/federation;
- security configuration;
- lifecycle and upgrade;
- HA/DR patterns;
- Keycloak observability;
- troubleshooting;
- Keycloak Operator patterns.

## Relationship to Argo CD

`argocd-expert-pack` owns generic Argo CD mechanics.

This repository may contain one Keycloak Application/Project example to show consumption, but must not become another GitOps training repository.

## Relationship to Cluster Factory

Cluster provisioning, CNI/CSI, cluster upgrades and generic Kubernetes operations remain owned by `k8s-openshift-cluster-factory`.

## Rule

When a concern is generic to all shared services, link to the canonical owner.

When a concern is Keycloak-specific, keep it here.
