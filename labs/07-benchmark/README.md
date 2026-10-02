# Lab 07 — Benchmark

## Objectif
Poser une base simple de benchmark reproductible sans versionner de credential.

## Contenu
- scripts `k6/`;
- jeux de variables d’environnement sans valeur sensible;
- modèle de rapport dans `evidence/`.

## Exécution

Les credentials sont fournis uniquement au runtime :

```bash
export BASE_URL=http://localhost:8080
export REALM=master
export CLIENT_ID=admin-cli
export USERNAME=admin
export PASSWORD='<runtime-only-password>'
k6 run k6/token-request.js
```

## Premier scénario recommandé
- service account token request ;
- charge progressive ;
- observation des temps de réponse, erreurs, CPU, mémoire, DB et logs.

## Ensuite
- login interactif ;
- comparaison avec configuration différente ;
- benchmark avec panne simulée.

## Règle de preuve

Les rapports peuvent conserver métriques, versions et résultats, mais jamais token, mot de passe ou client secret.
