# Learning Path

## Vue d’ensemble
Le parcours est organisé en huit niveaux. L’idée n’est pas de “tout lire”, mais de monter en maîtrise par couches successives.

## Niveau 0 — socle IAM
Lire :
- `docs/01-fundamentals/01-iam-oidc-oauth2-saml-basics.md`
- `docs/01-fundamentals/02-keycloak-architecture-overview.md`
- `docs/01-fundamentals/04-realms-clients-users-groups-roles.md`

Objectif :
- comprendre la différence entre authentification, autorisation, fédération et brokering ;
- distinguer realm, client, scope, rôle, groupe, mapper ;
- situer Keycloak dans une architecture applicative.

## Niveau 1 — prise en main locale
Faire :
- `labs/00-local-compose`
- `labs/01-admin-api-and-kcadm`

Objectif :
- démarrer un environnement local ;
- créer un realm, un client public, un client confidentiel, des rôles et des groupes ;
- exporter et réimporter la configuration.

## Niveau 2 — design d’un realm
Lire :
- `docs/02-admin-and-realm-design/*`

Objectif :
- modéliser proprement rôles et groupes ;
- éviter les scopes trop généreux ;
- préparer des clients cohérents selon leur nature : SPA, backend, proxy legacy, service account, partenaire.

## Niveau 3 — sécurité
Lire :
- `docs/03-security/*`

Objectif :
- poser une baseline de sécurité ;
- traiter reverse proxy, hostname, TLS, truststore, client policies, secret rotation, token exchange, passkeys, DPoP et service accounts ;
- savoir quand une fonctionnalité est pertinente, et quand elle introduit un risque ou une complexité inutile.

## Niveau 4 — exploitation
Lire :
- `docs/04-operations/*`
- `docs/08-observability-and-benchmark/*`

Faire :
- `labs/05-observability`
- `labs/06-upgrade-and-failover`

Objectif :
- superviser Keycloak ;
- comprendre la management interface ;
- raisonner SLI/SLO ;
- préparer upgrade, backup/restore, troubleshooting et runbooks.

## Niveau 5 — haute disponibilité et PRA
Lire :
- `docs/05-high-availability/*`
- `docs/09-reference-architectures/*`

Objectif :
- distinguer single-cluster, multi-cluster, multi-site PRA ;
- connaître les contraintes de latence ;
- documenter clairement ce qui est supporté, acceptable ou expérimental.

## Niveau 6 — extensions
Lire :
- `docs/06-development-and-extension/*`

Objectif :
- savoir quand rester en configuration standard ;
- savoir quand basculer vers SPI, authenticator custom, user storage provider, thème, event listener.

## Niveau 7 — intégrations réelles
Lire :
- `docs/07-integrations/*`

Faire :
- `labs/08-integrations/*`

Objectif :
- choisir le bon pattern selon le type d’application ;
- distinguer SPA pure, BFF, resource server, auth proxy, gateway et intégration SAML ;
- intégrer Keycloak à des applications modernes et legacy sans confusion sur les responsabilités.

## Niveau 8 — niveau expert
Faire :
- `labs/07-benchmark`
- revue complète des runbooks ;
- rédaction d’une architecture cible dans `architecture/`.

Objectif :
- être capable d’arbitrer entre simplicité, sécurité, disponibilité, coût d’exploitation et supportabilité ;
- défendre un design en comité d’architecture ;
- industrialiser un socle Keycloak crédible en entreprise.
