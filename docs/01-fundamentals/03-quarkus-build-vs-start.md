# 03 Quarkus Build Vs Start

## Objectif
Comprendre la différence entre build et start.

## Quand utiliser
Lorsqu’on prépare une image ou un runtime.

## Prérequis
- conteneurs
- variables d’environnement

## Concepts clés
- configuration build-time
- runtime
- optimisation image

## Procédure / design
Distinguer ce qui doit être figé dans l’image et ce qui peut rester paramétrable au runtime.

## Pièges fréquents
- injecter au runtime des options prévues au build
- reconstruire trop souvent l’image

## Checklist
- [ ] Options build-time identifiées
- [ ] pipeline image/runtimes clarifié


## Références officielles

- https://www.keycloak.org/guides
- https://www.keycloak.org/docs/latest/server_admin/index.html
- https://www.keycloak.org/docs/latest/release_notes/index.html

- https://www.keycloak.org/server/all-config
