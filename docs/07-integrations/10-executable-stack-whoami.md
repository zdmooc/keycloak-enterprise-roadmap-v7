# Stack exécutable locale — Keycloak + oauth2-proxy + Traefik + whoami

## Objectif
Fournir une démonstration locale simple mais complète d’un SSO navigateur :
- l’utilisateur accède à `whoami.localhost:8088` ;
- Traefik relaie vers oauth2-proxy ;
- oauth2-proxy redirige vers Keycloak ;
- après authentification, oauth2-proxy relaie vers l’application `whoami`.

## Pourquoi ce scénario est important
Il montre un pattern fréquent en entreprise :
- **protéger une application existante** sans la modifier profondément ;
- centraliser l’authentification ;
- propager quelques en-têtes utiles au backend ;
- documenter clairement la frontière de confiance.

## Composants
- **Keycloak** : fournisseur OIDC et authentification ;
- **oauth2-proxy** : point de contrôle d’authentification et de session navigateur ;
- **Traefik** : reverse proxy frontal ;
- **whoami** : backend minimal qui affiche la requête reçue.

## Ports locaux
- `8080` : Keycloak
- `8088` : route applicative exposée par Traefik
- `8089` : dashboard Traefik
- `4180` : oauth2-proxy en direct pour debug éventuel

## Étapes minimales
1. `cd scenarios/01-keycloak-oauth2-proxy-traefik-whoami`
2. `cp env/.env.example .env`
3. `make up`
4. `make smoke`
5. ouvrir `http://whoami.localhost:8088`
6. se connecter avec `demo / demopass`

## Frontière de confiance
Le backend `whoami` ne doit pas être exposé directement aux utilisateurs.
Le backend ne doit faire confiance aux en-têtes injectés par le proxy que si :
- l’accès réseau direct est bloqué ;
- la chaîne de proxy est maîtrisée ;
- la configuration des en-têtes est documentée.

## Preuves attendues
- capture de la page de login Keycloak ;
- capture de la page whoami après login ;
- sortie de `make smoke` ;
- export de logs Keycloak / oauth2-proxy / Traefik.

## Variantes futures
- HTTPS local avec `mkcert` ;
- Ingress Kubernetes ;
- version `oauth2-proxy + nginx auth_request` ;
- BFF Spring Boot.
