# Scenario 02 — Keycloak + Spring Boot + SPA/BFF

## Objectif
Montrer **trois façons cohérentes** d’intégrer Keycloak dans une application moderne :
1. **client web Spring Boot** avec login OIDC côté serveur ;
2. **resource server** validant des JWT ;
3. **SPA + BFF** pour réduire l’exposition des tokens au navigateur.

## Architecture
```text
A. Browser -> Spring Boot Web Client -> Keycloak
B. SPA -> BFF -> Resource API -> Keycloak
C. API client -> Resource Server -> JWKS Keycloak
```

## Répertoire
- `apps/web-client/` : propriétés Spring Boot OIDC login
- `apps/resource-server/` : config JWT
- `apps/spa-bff/` : exemple de découpage
- `compose/docker-compose.yml`
- `tests/`

## Quand choisir quoi
### Client OIDC côté serveur
À choisir pour :
- application MVC ou serveur de rendu ;
- session serveur classique ;
- logique métier fortement couplée au backend web.

### Resource server
À choisir pour :
- API REST moderne ;
- validation explicite du JWT ;
- séparation claire entre authn et autorisation applicative.

### SPA + BFF
À choisir pour :
- frontend riche ;
- volonté de limiter la présence des tokens dans le navigateur ;
- meilleure maîtrise des cookies serveur et de la rotation de session.

## Démarrage simplifié
```bash
docker compose -f compose/docker-compose.yml up -d
```

## Tests minimum
### Test 1 — JWKS
```bash
curl http://localhost:8080/realms/demo/protocol/openid-connect/certs
```

### Test 2 — token client credentials de démo
```bash
curl -X POST   http://localhost:8080/realms/demo/protocol/openid-connect/token   -d grant_type=client_credentials   -d client_id=api-client   -d client_secret=change-me
```

### Test 3 — appel API protégée
```bash
curl -H "Authorization: Bearer <token>" http://localhost:8085/api/me
```

## Décisions d’architecture
- ne pas utiliser un auth proxy comme unique mécanisme pour une API moderne ;
- éviter les refresh tokens en stockage persistant côté navigateur si le BFF est possible ;
- documenter la frontière entre authentification, session et autorisation métier.

## Preuves attendues
- login web réussi ;
- token valide sur l’API ;
- diagramme comparatif des 3 patterns ;
- justification du pattern retenu pour une application cible réelle.
