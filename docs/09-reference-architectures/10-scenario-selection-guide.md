# 10 Scenario selection guide

## Objectif
Aider à choisir rapidement le **bon scénario de référence** selon la nature de l’application.

## Tableau de décision simplifié
| Type d’application | Pattern conseillé | Pourquoi | À éviter |
|---|---|---|---|
| Outil HTTP simple ou legacy | Traefik/NGINX + oauth2-proxy | faible modification applicative | exposer le backend en direct |
| API moderne | resource server JWT | validation explicite, claire et robuste | reposer uniquement sur des headers injectés |
| SPA sensible aux risques de token dans le navigateur | SPA + BFF | réduit l’exposition des tokens | stocker des refresh tokens en clair côté navigateur |
| Application web Spring classique | client OIDC côté serveur | session gérée côté appli | mélanger logique BFF et proxy sans justification |
| Workload machine-to-machine sur cluster | service account / workload identity | moins de secrets statiques | secret partagé longue durée |

## Raccourcis pratiques
- **Je ne peux presque pas modifier l’application** → commencer par le scénario 01 ou 03.
- **Je développe l’API** → commencer par le scénario 02 côté resource server.
- **Je veux éviter les tokens dans le navigateur** → scénario 02 variante BFF.
- **Je protège un batch ou un contrôleur K8s** → scénario 04.

## Checklist de choix
- [ ] L’application sait-elle valider un JWT elle-même ?
- [ ] Peut-on modifier le code ?
- [ ] Veut-on limiter l’exposition des tokens côté navigateur ?
- [ ] Le backend est-il totalement isolé derrière le frontal ?
- [ ] Le pattern retenu est-il compréhensible par l’équipe d’exploitation ?

## Liens
- `scenarios/01-keycloak-oauth2-proxy-traefik-whoami/`
- `scenarios/02-keycloak-springboot-spa-bff/`
- `scenarios/03-keycloak-nginx-authrequest-legacy/`
- `scenarios/04-keycloak-k8s-serviceaccount-machine-auth/`


## Scénario V7 recommandé pour démarrer
Pour une première démonstration reproductible, commencer par `scenarios/01-keycloak-oauth2-proxy-traefik-whoami/`. C’est le scénario le plus rapide à exécuter localement et le plus utile pour illustrer un reverse proxy + auth proxy + IdP.
