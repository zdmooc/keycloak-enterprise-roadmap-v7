# Multi-Cluster — current direction

## Status — 2026-10-01

For new Keycloak upstream architecture work, evaluate **multi-cluster v2 / stateless** first.

Keycloak 26.8.0 promotes that model to supported. The older multi-cluster v1 (`multi-site`) direction is deprecated.

## Why consider multiple clusters

Only when requirements justify the complexity:
- cluster-level fault-domain separation;
- disaster recovery targets beyond one cluster;
- operational independence;
- business/regulatory constraints.

## Design questions

- database topology and write availability;
- latency between Keycloak and database;
- routing/failover;
- session behavior;
- cache/stateless mode;
- realm/configuration change propagation;
- secret/certificate propagation;
- DNS/load balancer convergence;
- RTO/RPO;
- capacity during site loss.

## Evidence required

A diagram is not HA evidence.

Validate:
- node loss;
- cluster loss;
- database failover;
- routing failover;
- login/token refresh during failure;
- recovery and resynchronization;
- measured RTO/RPO.

## Boundary

This repository documents the Keycloak-specific architecture.

Cluster lifecycle and multi-cluster platform provisioning remain owned by `k8s-openshift-cluster-factory`.
