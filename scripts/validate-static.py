#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
import re
import sys

import yaml

ROOT = pathlib.Path(__file__).resolve().parents[1]
errors: list[str] = []

ACTIVE_PREFIXES = (
    "gitops/argocd/",
    "manifests/",
    "install/01-crc-local/",
    "install/02-kind-local/",
    "labs/00-local-compose/",
    "labs/04-operator-openshift/",
    "scenarios/01-keycloak-oauth2-proxy-traefik-whoami/",
)

JWT_RE = re.compile(r"eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}")
PRIVATE_KEY_RE = re.compile(r"-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----")

for path in ROOT.rglob("*"):
    if not path.is_file() or ".git" in path.parts:
        continue
    rel = path.relative_to(ROOT).as_posix()
    try:
        text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        continue

    if JWT_RE.search(text):
        errors.append(f"{rel}: JWT-like token committed")
    if PRIVATE_KEY_RE.search(text):
        errors.append(f"{rel}: private key material committed")

    if path.suffix.lower() == ".json":
        if rel.startswith(ACTIVE_PREFIXES):
            try:
                obj = json.loads(text)
            except json.JSONDecodeError as exc:
                errors.append(f"{rel}: invalid JSON: {exc}")
            else:
                if isinstance(obj, dict) and any(k in obj for k in ("access_token", "refresh_token", "id_token")):
                    errors.append(f"{rel}: token response JSON must not be committed")

    if rel.startswith(ACTIVE_PREFIXES) and path.suffix.lower() in {".yaml", ".yml"}:
        try:
            docs = [d for d in yaml.safe_load_all(text) if d is not None]
        except Exception as exc:
            errors.append(f"{rel}: invalid YAML: {exc}")
            continue
        for doc in docs:
            if isinstance(doc, dict) and doc.get("kind") == "Secret":
                errors.append(f"{rel}: Kubernetes Secret object is forbidden in versioned YAML")

    if rel.startswith(ACTIVE_PREFIXES):
        if "keycloak-enterprise-roadmap-v3" in text or "example.invalid/repo.git" in text:
            errors.append(f"{rel}: stale GitOps repository reference")
        if "KEYCLOAK_ADMIN_PASSWORD" in text or re.search(r"\bKEYCLOAK_ADMIN\b", text):
            errors.append(f"{rel}: deprecated bootstrap admin environment variable")
        if "apiVersion: k8s.keycloak.org/v2alpha1" in text:
            errors.append(f"{rel}: active Keycloak CR must use v2beta1")
        if "quay.io/keycloak/keycloak:26.1" in text:
            errors.append(f"{rel}: stale active Keycloak 26.1 image pin")

for forbidden in [
    ROOT / "labs-local/01-keycloak-minimal/admin-token.json",
    ROOT / "labs-local/01-keycloak-minimal/alice-token.json",
    ROOT / "labs-local/01-keycloak-minimal/payload.json",
]:
    if forbidden.exists():
        errors.append(f"{forbidden.relative_to(ROOT)}: generated auth artifact returned")

required = [
    ROOT / "SECURITY.md",
    ROOT / "docs/governance/O6_PLAN.md",
    ROOT / "docs/governance/OWNERSHIP.md",
    ROOT / "docs/11-feature-radar/CURRENT_BASELINE_2026-10-01.md",
    ROOT / "gitops/argocd/project.yaml",
    ROOT / "gitops/argocd/application.yaml",
    ROOT / "scenarios/01-keycloak-oauth2-proxy-traefik-whoami/realm/demo-realm.template.json",
    ROOT / "scenarios/01-keycloak-oauth2-proxy-traefik-whoami/scripts/prepare.sh",
]
for path in required:
    if not path.exists():
        errors.append(f"missing required O6 asset: {path.relative_to(ROOT)}")

if errors:
    print("KEYCLOAK_STATIC_VALIDATION=FAIL")
    for err in errors:
        print(f"- {err}")
    sys.exit(1)

print("KEYCLOAK_STATIC_VALIDATION=PASS")
