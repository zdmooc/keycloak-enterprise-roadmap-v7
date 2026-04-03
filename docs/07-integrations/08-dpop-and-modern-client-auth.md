# 08 DPoP and Modern Client Authentication

## Objectif
Comprendre quand DPoP ou d’autres mécanismes modernes de preuve de possession peuvent réduire le risque lié aux bearer tokens.

## Contexte
Un bearer token volé peut souvent être rejoué tant qu’il est valide. DPoP ajoute une preuve cryptographique liée à la requête et au client pour réduire ce risque.

## Quand considérer DPoP
- exposition internet ;
- clients sensibles ;
- besoin de limiter le rejeu de jetons ;
- environnement où les bearer tokens seuls sont jugés trop permissifs.

## Quand rester simple
- API internes derrière frontières réseau et mTLS ;
- complexité d’exploitation trop élevée pour le gain attendu ;
- outillage client encore immature dans le contexte du projet.

## Recommandation
- commencer par bien maîtriser les fondamentaux : audience, scopes, rotation, durée de vie, cookies ou stockage sûr, TLS ;
- n’ajouter DPoP que si le modèle de menace le justifie ;
- traiter DPoP comme une **amélioration ciblée**, pas comme un réflexe universel.

## Liens avec d’autres approches
- mTLS côté client ;
- service account Kubernetes ;
- secret rotation ;
- JWT Authorization Grants si l’usage correspond mieux au besoin.

## Checklist
- [ ] menace de rejeu explicitement identifiée
- [ ] support client vérifié
- [ ] traces observabilité prévues
- [ ] stratégie fallback définie

## Références officielles
- Keycloak release notes 26.4
- Keycloak server features
