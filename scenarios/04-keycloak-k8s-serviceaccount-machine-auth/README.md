# Scenario 04 — Kubernetes service account machine authentication

## Objectif
Montrer un pattern **machine-to-machine** sur Kubernetes en réduisant l’usage de secrets statiques.

## Cas d’usage
- job batch ;
- operator interne ;
- microservice sur cluster ;
- contrôleur qui doit appeler une API protégée.

## Architecture
```text
Pod with ServiceAccount
  -> Kubernetes token / workload identity
  -> Keycloak client authentication
  -> access token
  -> protected API
```

## Démarche
1. créer un ServiceAccount dédié ;
2. lier le workload à ce compte ;
3. configurer le client Keycloak selon le mode retenu ;
4. obtenir un access token ;
5. appeler l’API ;
6. tracer l’audit de bout en bout.

## Répertoire
- `manifests/serviceaccount.yaml`
- `manifests/job.yaml`
- `tests/request-token.sh`

## Décisions
- secret statique seulement si aucune meilleure option n’est disponible ;
- rotation automatique privilégiée ;
- séparation stricte des comptes techniques par workload.

## Preuves attendues
- description du compte de service ;
- logs du pod ;
- preuve d’obtention d’un token ;
- preuve d’appel API réussi.
