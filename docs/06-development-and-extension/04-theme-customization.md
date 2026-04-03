# 04 Theme Customization

## Objectif
Adapter le rendu sans perdre la capacité d’upgrade.

## Quand utiliser
Quand les features natives ne suffisent pas.

## Prérequis
- Java
- notions de packaging
- Keycloak fundamentals

## Concepts clés
- SPI
- extension
- compatibilité
- tests d’upgrade

## Procédure / design
Toujours partir d’un besoin métier ou technique clair, isoler l’extension, écrire des tests et préparer l’upgrade path.

## Pièges fréquents
- customiser trop tôt
- développer une extension sans stratégie d’upgrade

## Checklist
- [ ] besoin justifié
- [ ] testée
- [ ] impact upgrade documenté


## Références officielles

- https://www.keycloak.org/guides
- https://www.keycloak.org/docs/latest/server_admin/index.html
- https://www.keycloak.org/docs/latest/release_notes/index.html

- https://www.keycloak.org/guides
- https://www.keycloak.org/server/features
