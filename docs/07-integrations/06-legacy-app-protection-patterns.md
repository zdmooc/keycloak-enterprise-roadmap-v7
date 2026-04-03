# 06 Legacy App Protection Patterns

## Objectif
Sécuriser une application legacy sans refonte complète.

## Patterns principaux
### Reverse proxy authentifiant
Le proxy force une authentification OIDC/SAML avant d’atteindre l’application.

### Module d’authentification serveur web
Exemple : module Apache `mod_auth_openidc` ou équivalent. Très utile quand le serveur HTTP frontal existe déjà et que l’application n’a pas de support OIDC natif.

### Gateway devant plusieurs applications legacy
Utile quand on veut homogénéiser l’entrée mais demande une gouvernance forte sur les headers et les chemins.

## Règles de décision
- application modifiable ? utiliser une intégration standard plus proche de l’application ;
- application quasi figée ? auth proxy ;
- besoin de granularité métier ? ne pas tout déléguer au proxy.

## Ce qu’il faut documenter
- quels headers ou variables serveur transmettent l’identité ;
- si l’application peut être atteinte sans le frontal ;
- comment sont gérés logout, timeout et montée de privilège.

## Pièges fréquents
- donner une confiance aveugle à `X-Forwarded-*` ou à des headers d’identité ;
- ne pas isoler le backend ;
- oublier les websockets, uploads, gros fichiers, callbacks et chemins de santé.

## Checklist
- [ ] application non exposée directement
- [ ] headers d’identité signés ou contrôlés par isolement réseau
- [ ] logout et timeout testés
- [ ] documentation des exceptions d’URL
- [ ] runbook incident en cas de boucle 302

## Références officielles
- Keycloak guides: https://www.keycloak.org/guides
- NGINX auth_request: https://nginx.org/en/docs/http/ngx_http_auth_request_module.html
