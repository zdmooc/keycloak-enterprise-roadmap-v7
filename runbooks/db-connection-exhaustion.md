# Runbook — épuisement des connexions DB

## Symptômes
- lenteurs globales ;
- erreurs intermittentes ;
- login dégradé ;
- pods vivants mais service peu réactif.

## Vérifications
- métriques DB ;
- logs Keycloak ;
- saturation du pool ;
- incidents réseau DB.

## Actions
- réduire la pression ou augmenter proprement la capacité ;
- analyser la cause avant d’augmenter aveuglément les limites ;
- vérifier les changements récents.
