# Roadmap

## O6 — 2026-10-01

- [x] I1 — token / secret truth
- [x] I2 — GitOps cleanup
- [x] I3 — runtime secret delivery
- [x] I4 — Keycloak 26.8 / Operator / HA refresh
- [x] I5 — static/security CI implemented
- [x] I6 — Keycloak 26.8 container runtime proof
- [ ] I7 — final static closeout + P0 synchronization

## Current evidence

- Keycloak 26.8 container runtime: proven;
- current CRC/RHBK runtime: pending;
- HA/multi-site: reference until failure tests;
- production: not claimed.

## Mission-driven extensions

- fresh CRC/RHBK replay;
- LDAP/AD federation runtime;
- identity brokering runtime;
- WebAuthn/passkeys;
- client policies/secret rotation;
- Operator upgrade;
- PostgreSQL backup/restore;
- multi-cluster v2 failure tests;
- real Spring Boot/BFF scenario.
