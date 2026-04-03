# Scenarios

Ce dossier contient les **scénarios intégrés de bout en bout** du dépôt.

Chaque scénario suit la même logique :
- `README.md` : architecture, prérequis, démarrage, tests ;
- `compose/` ou `manifests/` : éléments rejouables ;
- `env/` : variables d’exemple ;
- `tests/` : commandes de validation ;
- `evidence/` : captures et résultats attendus.

## Ordre conseillé
1. `01-keycloak-oauth2-proxy-traefik-whoami`
2. `02-keycloak-springboot-spa-bff`
3. `03-keycloak-nginx-authrequest-legacy`
4. `04-keycloak-k8s-serviceaccount-machine-auth`
