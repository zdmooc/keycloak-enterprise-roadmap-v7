# Installation and deployment surfaces

**O6 classification — 2026-10-01**

| Directory | Role | Status |
|---|---|---|
| `01-crc-local/` | Red Hat Build of Keycloak Operator lab on OpenShift Local | ACTIVE LAB / CURRENT CONTRACT |
| `02-kind-local/` | upstream Keycloak Operator lab on Kind | ACTIVE LAB / CURRENT CONTRACT |
| `03-cloud-terraform/` | historical cloud IaC examples | REFERENCE / REQUALIFICATION_REQUIRED |
| `04-ansible/` | VM/bare-metal deployment reference | REFERENCE / REQUALIFICATION_REQUIRED |
| `05-cicd-gitlab/` | CI/CD patterns | REFERENCE / PARTIAL VALIDATION |

## Canonical rule

This repository does not own generic cluster provisioning.

For Kubernetes/OpenShift cluster lifecycle use:
`k8s-openshift-cluster-factory`.

## Secrets

No active installation path should require a committed credential Secret.

Local labs create the DB Secret from runtime environment variables. Operator-generated bootstrap-admin credentials are temporary and must never be committed.

## Cloud Terraform

The cloud examples contain historically useful architecture ideas but old provider/platform pins. They are not labeled production-ready until refreshed and tested against current cloud versions.

## Ansible

The Ansible area demonstrates VM/bare-metal concepts. It requires requalification of:
- Keycloak version;
- Java/runtime prerequisites;
- checksum;
- systemd bootstrap process;
- clustering;
- TLS;
- database;
- rolling upgrade.

## Evidence

Use `evidence/CLAIM_EVIDENCE_MATRIX.md` rather than directory names or README wording to determine maturity.
