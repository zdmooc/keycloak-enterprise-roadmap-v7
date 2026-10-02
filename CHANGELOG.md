# Changelog

## 2026-10-02 — credential hygiene follow-up

- removed stale Bitnami Kind values containing fixed lab credentials;
- required runtime credentials in kcadm/export helper scripts;
- removed fixed benchmark password from current examples;
- strengthened active-surface validation against common weak fixed credentials;
- preserved the O6 evidence boundary: container runtime proven, CRC/RHBK still NOT_PROVEN.

## 2026-10-01 — O6 hardening

- removed generated OAuth access/refresh tokens from current main;
- documented Git-history exposure boundary;
- removed fixed credential Kubernetes Secret manifests;
- generated local scenario secrets at runtime;
- moved active Keycloak examples to 26.8.0 / CR v2beta1;
- cleaned stale V3/example.invalid Argo CD manifests;
- added bounded OpenShift GitOps Keycloak contract;
- refreshed HA roadmap for multi-cluster v2/stateless direction;
- classified cloud Terraform/Ansible as requalification references;
- added static/security CI;
- added Keycloak 26.8 runtime proof with restart persistence.

## 2026-10-01 — O6 complete

- dedicated runtime evidence file added;
- CRC/RHBK evidence template added;
- final repository closeout CI `36878286683` succeeded on `a00afa635ad4a2e067f3b67bae29948d7662af5c`;
- O6 promoted to COMPLETE;
- current CRC/RHBK remains NOT_PROVEN and is an environment-specific future evidence gate.
