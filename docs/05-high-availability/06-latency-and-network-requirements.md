# Latency and Network Requirements

## Objectif
Ancrer le design HA dans la réalité réseau.

## Règle de base
Plus la topologie répartit Keycloak, plus la latence devient structurante pour :
- les sessions ;
- le cache ;
- les comportements de cluster ;
- la qualité d’expérience.

## Ce qu’il faut mesurer
- RTT entre nœuds ;
- RTT vers la base ;
- stabilité réseau ;
- temps de convergence après panne ;
- impact sur login, refresh token et administration.

## Bonne pratique
Documenter noir sur blanc les hypothèses de latence qui ont servi au design.
