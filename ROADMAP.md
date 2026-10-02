# Roadmap

## O6 — 2026-10-01

- [x] I1 — token / secret truth
- [x] I2 — GitOps cleanup
- [x] I3 — runtime secret delivery
- [x] I4 — Keycloak 26.8 / Operator / HA refresh
- [x] I5 — static/security CI implemented
- [x] I6 — Keycloak 26.8 container runtime proof
- [x] I7 — final static closeout + P0 synchronization

## Current evidence

- O6 status: **COMPLETE**;
- final static closeout before P0 sync: `36878286683` SUCCESS;
- Keycloak 26.8 container runtime: proven;
- shared CRC/RHBK bootstrap subset: `CRC_SHARED_IDENTITY_BOOTSTRAP_PROVEN` on 2026-10-02;
- full specialist CRC promotion (metrics/token/restart/upgrade as applicable): pending;
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
