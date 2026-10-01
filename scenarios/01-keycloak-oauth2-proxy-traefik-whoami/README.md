# Scenario 01 — Keycloak + oauth2-proxy + Traefik + whoami

## Objectif

Montrer une chaîne SSO navigateur locale, lisible et rejouable de bout en bout.

```text
Browser
  -> Traefik
    -> oauth2-proxy
      -> Keycloak
    -> whoami
```

## Sécurité O6

Aucun mot de passe, client secret, cookie secret ou token concret n'est versionné.

`scripts/prepare.sh` génère localement :
- `.env`;
- `generated/demo-realm.json`;
- mot de passe bootstrap admin;
- client secret OIDC;
- cookie secret oauth2-proxy;
- mot de passe de l'utilisateur de démonstration.

Ces fichiers sont ignorés par Git et les valeurs ne sont pas affichées par les scripts.

## Fichiers

- `compose/docker-compose.yml`;
- `compose/traefik/dynamic.yml`;
- `realm/demo-realm.template.json`;
- `env/.env.example`;
- `scripts/prepare.sh`;
- `scripts/up.sh`;
- `tests/smoke.sh`.

## Démarrage

```bash
make up
make smoke
```

Le premier `make up` génère automatiquement les secrets de lab.

Pour consulter localement les identifiants de démonstration si nécessaire :

```bash
grep -E '^(KC_BOOTSTRAP_ADMIN_USERNAME|DEMO_USER_USERNAME)=' .env
```

Ne jamais copier les mots de passe/tokens dans une preuve Git.

## Endpoints

- application protégée : `http://whoami.localhost:8088`;
- Keycloak : `http://keycloak.localhost:8080`;
- Traefik dashboard : `http://localhost:8089/dashboard/`.

## Smoke test

Le smoke valide :
- découverte OIDC du realm;
- disponibilité Keycloak;
- redirection d'authentification depuis whoami;
- accessibilité du dashboard Traefik.

Il ne stocke pas de token.

## Limites

Ce scénario utilise HTTP local et `start-dev`.

Il n'est pas une architecture de production. Pour la production : TLS, hostname/admin hostname, secret manager, base supportée, politique réseau, SSO admin, observabilité et stratégie HA/DR sont traités ailleurs dans le dépôt.
