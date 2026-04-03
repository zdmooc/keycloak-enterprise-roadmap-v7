# Scenario 01 — Keycloak + oauth2-proxy + Traefik + whoami (V7 exécutable)

## Objectif
Montrer une chaîne SSO navigateur simple, lisible et **rejouable de bout en bout** en local.

## Ce que la V7 apporte ici
La V6 présentait déjà l’architecture. La V7 ajoute :
- un `docker-compose.yml` réellement branchable ;
- un realm importé automatiquement ;
- un client OIDC confidentiel ;
- un utilisateur de démonstration ;
- un `Makefile` ;
- des scripts `preflight`, `up`, `down`, `logs`, `smoke`.

## Architecture
```text
Browser
  -> Traefik (whoami.localhost:8088)
    -> oauth2-proxy
      -> Keycloak (keycloak.localhost:8080)
    -> whoami
```

## Identifiants de démonstration
- **admin Keycloak** : `admin / adminadmin`
- **utilisateur** : `demo / demopass`

## Flux
1. le navigateur appelle `http://whoami.localhost:8088/`
2. Traefik route vers `oauth2-proxy`
3. `oauth2-proxy` redirige vers Keycloak
4. l’utilisateur s’authentifie
5. Keycloak renvoie vers `oauth2-proxy`
6. `oauth2-proxy` crée sa session et relaie vers `whoami`
7. `whoami` affiche les informations de requête et certains en-têtes utiles

## Répertoire
- `compose/docker-compose.yml`
- `compose/traefik/dynamic.yml`
- `realm/demo-realm.json`
- `env/.env.example`
- `scripts/`
- `tests/smoke.sh`
- `Makefile`

## Pré requis
- Docker Desktop ou Docker Engine + Compose v2 ;
- ports `8080`, `8088`, `8089`, `4180` libres ;
- les domaines `*.localhost` doivent résoudre localement. Sur la plupart des postes modernes c’est déjà le cas. Si nécessaire, ajouter :
  - `127.0.0.1 keycloak.localhost`
  - `127.0.0.1 whoami.localhost`

## Démarrage rapide
```bash
cp env/.env.example .env
make up
make smoke
```

Ensuite ouvrir :
- `http://whoami.localhost:8088`
- `http://keycloak.localhost:8080/admin`

## Commandes utiles
```bash
make preflight
make up
make logs
make smoke
make down
```

## Ce que vérifie le smoke test
- que Keycloak répond ;
- que le document OIDC du realm `demo` est accessible ;
- que le frontal `whoami.localhost:8088` renvoie bien une redirection d’authentification ;
- que Traefik répond.

## Points d’attention
- le backend `whoami` n’est pas exposé directement au poste client ;
- `oauth2-proxy` est ici le vrai point de contrôle navigateur ;
- en local, le cookie est configuré sans `Secure` car le scénario est en HTTP ;
- pour un usage sérieux, prévoir HTTPS, secret manager, rotation de secrets, observabilité et limitation réseau.

## Résultat attendu
Après authentification, la page `whoami` doit s’afficher et montrer notamment :
- l’URL atteinte ;
- des informations de requête ;
- les en-têtes transitant jusqu’au backend.

## Preuves à déposer
- capture de la page de login Keycloak ;
- capture de la page `whoami` après login ;
- sortie de `make smoke` ;
- copie de `docker compose ps`.
