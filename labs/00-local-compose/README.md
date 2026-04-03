# Lab 00 — Local Compose

## Objectif
Monter un lab local crédible avec PostgreSQL + Keycloak, health, metrics et export de realm.

## Pré-requis
- Docker ou Docker Desktop
- `docker compose`
- `curl`
- facultatif : `jq`

## Fichiers du lab
- `docker-compose.yml`
- `.env.example`
- `realm/` pour stocker des exports
- `evidence/` pour capturer les résultats

## Démarrage
```bash
cp .env.example .env
docker compose up -d
docker compose ps
docker compose logs keycloak --tail=50
```

## Vérifications minimales
```bash
curl -s http://localhost:9000/health/live
curl -s http://localhost:9000/health/ready
curl -s http://localhost:9000/metrics | head -40
```

## Exercice
1. se connecter à la console d’admin ;
2. créer un realm `demo` ;
3. créer un client public `demo-ui` ;
4. créer un client confidentiel `demo-api` ;
5. créer un rôle `reader` et un groupe `finance/readers` ;
6. exporter le realm.

## Ce que tu dois observer
- la séparation entre port applicatif et port de management ;
- l’état `ready` après démarrage ;
- l’apparition des métriques ;
- le comportement des logs si la DB n’est pas joignable.

## Preuves à déposer
- capture console ;
- sortie `docker compose ps` ;
- réponse `health/ready` ;
- extrait `metrics` ;
- export JSON du realm.
