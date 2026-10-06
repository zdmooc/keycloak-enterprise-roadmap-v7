# D-098 — SQY CaaS IAM / Secrets Mission Pack

**Status:** ARCHITECTURE_REUSE_READY / NEW RUNTIME REPLAY OPTIONAL

## Purpose

Map existing Keycloak/RHBK evidence and reference material to the SQY Expert Kubernetes/OpenShift mission.

This repository remains the IAM specialist. It does not become the CaaS owner.

## Existing assets to reuse

- OpenShift Operator installation patterns;
- OIDC/OAuth2 client and scope design;
- service accounts / machine-to-machine;
- client secret rotation;
- LDAP / Active Directory federation architecture;
- TLS / truststore / mTLS;
- logging / audit / troubleshooting;
- upgrade and compatibility;
- backup / restore;
- SRE / alerting;
- OpenShift enterprise reference architecture.

## Mission target

~~~text
Enterprise AD / IdP
       |
       v
Federation / Identity Brokering
       |
       v
Keycloak / RHBK
       |
       +--> OpenShift / platform identity integration
       +--> Workload OIDC clients
       +--> API / service identities
       |
       v
Groups / roles / scopes
       |
       v
RBAC / authorization
~~~

## Secret lifecycle

For each machine credential:
- owner identified;
- storage location identified;
- least privilege;
- rotation trigger and cadence;
- emergency revoke path;
- no secret committed to Git;
- audit/evidence after rotation.

Vault/CyberArk remain external integration boundaries unless an actual runtime is available.

## SQY-5 validation pack

The runtime replay should cover:
1. OIDC discovery;
2. JWKS retrieval;
3. valid token path;
4. invalid audience;
5. insufficient scope/role;
6. secret rotation or bounded client-secret replacement;
7. post-rotation validation;
8. audit/log capture.

## Active Directory boundary

LDAP/AD federation design is documented here.
A local Keycloak lab does not prove enterprise AD integration.

## Gate contribution

This document contributes to:
`CAAS_SECOPS_OBSERVABILITY_PACK_READY`.

Current existing CRC OIDC evidence may be referenced where already captured; do not duplicate it only to create a new claim.
