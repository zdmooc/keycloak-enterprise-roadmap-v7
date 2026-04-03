# Scenario 03 — Keycloak + NGINX auth_request + legacy app

## Objectif
Protéger une application legacy HTTP derrière NGINX avec un mécanisme d’autorisation en sous-requête.

## Architecture
```text
Browser -> NGINX -> auth endpoint -> Keycloak / session proxy
                     -> legacy app
```

## Principe
NGINX déclenche une sous-requête vers un endpoint d’authentification/autorisation.  
Si la sous-requête retourne `2xx`, la requête est autorisée.  
Si elle retourne `401` ou `403`, la requête vers l’application est bloquée.

## Pré requis
- savoir où est prise la décision d’accès ;
- garantir que l’application legacy n’est pas accessible en direct ;
- documenter les headers propagés.

## Fichiers
- `nginx/nginx.conf`
- `tests/curl-examples.sh`
- `evidence/`

## Tests
- accès sans session -> refus / redirection
- accès avec session -> autorisation
- accès direct legacy hors NGINX -> impossible
