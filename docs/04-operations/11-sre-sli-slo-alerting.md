# SRE, SLI, SLO and Alerting

## Objectif
Faire de Keycloak un service mesuré, pas seulement un produit installé.

## Exemples de SLI utiles
- disponibilité du endpoint de login ;
- disponibilité `health/ready` ;
- latence des appels clés ;
- erreurs sur émissions de tokens ;
- taux de succès des logins ;
- disponibilité de la DB et du cache.

## Exemples d’alertes
- health non prêt ;
- augmentation des erreurs 5xx ;
- saturation des connexions DB ;
- temps de réponse en hausse ;
- redémarrages répétés ;
- baisse du taux de login réussi.
