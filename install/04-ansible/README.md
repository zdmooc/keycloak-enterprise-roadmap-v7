# Ansible Keycloak — VM/Bare-Metal reference

**Status: REFERENCE / REQUALIFICATION_REQUIRED**

This area preserves a VM/bare-metal Keycloak deployment pattern for environments where Kubernetes is not the target.

Before operational use, requalify:
- Keycloak version and checksum;
- supported Java/runtime;
- current bootstrap-admin mechanism;
- TLS and hostname configuration;
- database support;
- systemd hardening;
- cache/clustering;
- rolling upgrade;
- backup/restore.

Credentials must come from Ansible Vault or an approved secret manager, never plaintext examples.

This area is not part of the active O6 CI/runtime proof.
