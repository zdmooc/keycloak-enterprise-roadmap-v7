# Lab 01 — Admin API and kcadm

## Objectif
Automatiser la création d’objets d’admin pour sortir du tout-console.

## Pré-requis
- `labs/00-local-compose` fonctionnel
- accès admin local

## Parcours
### 1. authentification admin
```bash
./scripts/login-admin.sh
```

### 2. vérifier les realms existants
```bash
./scripts/list-realms.sh
```

### 3. créer un realm de démonstration
Créer ou adapter les scripts suivants :
- `create-demo-realm.sh`
- `create-demo-client.sh`
- `create-demo-group-role.sh`

### 4. exporter
```bash
./scripts/export-demo-realm.sh
```

## Ce qu’il faut apprendre
- différence entre nom lisible et identifiant interne ;
- importance des scripts rejouables ;
- usage pratique de `kcadm.sh` ;
- intérêt de l’API d’admin pour l’industrialisation.

## Extension du lab
Ajouter :
- un service account ;
- un groupe ;
- un mapper ;
- une policy de client.

## Preuves
- commandes exécutées ;
- JSON de retour ;
- capture console ;
- export final.
