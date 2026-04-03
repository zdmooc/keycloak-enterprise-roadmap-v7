# Logging, Audit and Troubleshooting

## Objectif
Poser une stratégie de logs utile à l’exploitation, au support et aux audits.

## Questions de design
- où vont les logs ?
- quels niveaux sont activés ?
- comment corréler un incident fonctionnel avec les logs ?
- quels événements doivent être conservés ?
- comment traiter la volumétrie ?

## Runbook d’analyse rapide
1. qualifier le symptôme : login loop, invalid redirect, 401 API, lenteur, saturation DB ;
2. corréler l’horodatage avec les logs du reverse proxy, de Keycloak et de la DB ;
3. vérifier health et métriques ;
4. isoler si le problème est fonctionnel, réseau, config ou capacité.
