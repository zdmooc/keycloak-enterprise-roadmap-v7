# E2E scenario validation

## Objectif
Vérifier rapidement qu’un scénario intégré est démontrable devant un client, un recruteur ou un comité d’architecture.

## Checklist
- [ ] démarrage nominal reproductible
- [ ] login ou échange de token démontré
- [ ] preuve d’accès autorisé
- [ ] preuve d’accès refusé hors pattern prévu
- [ ] flux réseau documenté
- [ ] jetons / cookies / headers explicités
- [ ] limites et choix d’architecture expliqués
- [ ] captures déposées dans `evidence/`

## Sorties minimales à conserver
- `curl -I`
- capture navigateur
- logs Keycloak / proxy / backend
- commande de création ou récupération de token
- conclusion sur le pattern retenu


## Validation V7 exécutable
Pour le scénario 01, exécuter `make up`, puis `make smoke`, puis valider la connexion interactive sur `http://whoami.localhost:8088` avec `demo / demopass`.
