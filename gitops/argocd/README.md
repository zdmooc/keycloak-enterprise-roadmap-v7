# Argo CD

## Objectif
Déployer le socle Keycloak en mode GitOps.

## Structure recommandée
- `base/` : manifests communs
- `envs/dev/` : patchs dev
- `envs/prod/` : patchs prod
- `app-of-apps/` : applications Argo

## Principe
Ne pas versionner les secrets en clair. Utiliser un mécanisme de secret management adapté.
