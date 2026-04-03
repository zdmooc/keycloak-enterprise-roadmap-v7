# Hostname v2 and Reverse Proxy

## Objectif
Stabiliser les URLs, éviter les problèmes de redirection et sécuriser le trafic derrière un reverse proxy.

## Pourquoi c’est sensible
Une mauvaise configuration `hostname` / proxy provoque très souvent :
- boucles de redirection ;
- cookies invalides ;
- erreurs de callback ;
- liens admin incorrects ;
- confusion entre URL interne et URL publique.

## Règles de design
- définir clairement l’URL publique canonique ;
- ne pas confondre adresse de service interne et adresse visible des utilisateurs ;
- documenter qui termine TLS ;
- valider explicitement les headers de proxy attendus.

## Points à vérifier
- `hostname` ;
- `proxy-headers` ;
- certificat présenté côté frontal ;
- ports exposés ;
- policy sur `X-Forwarded-*` ou `Forwarded` ;
- cohérence du redirect URI côté clients.

## Runbook court
1. vérifier l’URL réellement demandée par le navigateur ;
2. vérifier les headers du reverse proxy ;
3. comparer avec la configuration Keycloak ;
4. tester le callback OIDC ;
5. analyser cookies et SameSite si nécessaire.

## Références
- https://www.keycloak.org/server/hostname
- https://www.keycloak.org/server/reverseproxy
