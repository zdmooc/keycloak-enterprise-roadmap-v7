# Lab 05 — Observability

## Objectif
Raccorder Keycloak à une chaîne d’observabilité simple mais exploitable.

## Cible minimale
- `health/live`
- `health/ready`
- `/metrics`
- ServiceMonitor
- dashboard Grafana de base
- au moins trois alertes simples

## Alertes minimales proposées
- instance non prête ;
- redémarrages répétés ;
- erreurs d’authentification en hausse.

## Résultats attendus
- scrape Prometheus visible ;
- dashboard lisible ;
- preuve d’alerte simulée ;
- mini-runbook d’investigation.
