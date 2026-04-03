# ADR-001 — Choix de topologie Keycloak

## Statut
Proposé

## Décision
Commencer par un single-cluster robuste avant d’envisager un multi-cluster.

## Justification
- simplicité d’exploitation ;
- meilleure lisibilité ;
- alignement avec les exigences de faible latence ;
- coût et risque plus faibles.

## Conséquences
- focus sur monitoring, DB, backup/restore et tests de panne ;
- multi-cluster seulement sur besoin métier justifié.
