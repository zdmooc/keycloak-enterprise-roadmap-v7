# Runbook — proxy headers mal configurés

## Symptômes
- URL générées incorrectes ;
- logout cassé ;
- callback erronée ;
- admin console incohérente.

## Vérifications
- `Forwarded` ou `X-Forwarded-*` ;
- hostname configuré ;
- terminaison TLS ;
- éventuel path prefix.

## Actions
- corriger la configuration proxy ;
- expliciter les paramètres Keycloak ;
- refaire les tests login/logout.
