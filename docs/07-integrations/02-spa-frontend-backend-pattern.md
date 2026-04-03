# 02 SPA Frontend Backend Pattern

## Objectif
Choisir le bon pattern pour sécuriser une SPA avec Keycloak sans introduire une architecture fragile ou trop exposée aux jetons dans le navigateur.

## Trois patterns utiles
### Pattern A — SPA publique + API resource server
La SPA utilise le JavaScript adapter ou une bibliothèque OIDC équivalente, obtient un token, puis appelle l’API.

**Avantages**
- simple à démarrer ;
- peu de composants ;
- bon pour POC et petits produits.

**Limites**
- les jetons vivent côté navigateur ;
- discipline forte nécessaire sur stockage, rafraîchissement, logout, exposition XSS.

### Pattern B — SPA + BFF
Le frontend parle à un Backend For Frontend qui gère l’échange OIDC, les cookies de session et les appels aux APIs.

**Avantages**
- réduit l’exposition des access tokens côté navigateur ;
- meilleur contrôle des cookies, du refresh token et du logout ;
- souvent plus propre pour un contexte entreprise.

**Limites**
- un composant serveur en plus ;
- conception plus exigeante.

### Pattern C — SPA derrière auth proxy
Le proxy authentifie l’utilisateur avant d’atteindre l’app.

**Avantages**
- très utile pour un portail statique ou une application quasi inchangée.

**Limites**
- moins fin pour des besoins d’autorisation applicative riche ;
- attention aux headers injectés.

## Recommandation pratique
- **SPA grand public simple** : Pattern A possible si l’équipe maîtrise vraiment OIDC côté navigateur.
- **Produit interne critique ou réglementé** : privilégier **BFF**.
- **Application peu modifiable** : auth proxy.

## Décisions structurantes
### Où vit la session ?
- dans Keycloak uniquement ;
- dans un cookie de session applicatif BFF ;
- dans un proxy d’authentification.

### Qui appelle l’API ?
- le navigateur avec bearer token ;
- le BFF avec propagation ou échange ;
- le proxy.

### Où porte l’autorisation métier ?
- jamais uniquement dans le front ;
- l’API doit rester autorité finale.

## Risques fréquents
- stocker des tokens dans `localStorage` sans justification ;
- traiter le front comme une zone de confiance ;
- injecter des rôles front-only sans contrôle backend ;
- oublier CORS, SameSite, CSRF et logout cohérent.

## Checklist
- [ ] pattern choisi explicitement
- [ ] stockage des jetons documenté
- [ ] stratégie logout global et applicatif décrite
- [ ] autorisation métier portée par le backend
- [ ] CORS et cookies revus
- [ ] audiences des APIs définies

## Preuves attendues
- schéma de séquence login
- démonstration d’accès API avec rôle insuffisant
- démonstration logout

## Références officielles
- Keycloak JavaScript adapter: https://www.keycloak.org/guides
- Keycloak securing apps overview: https://www.keycloak.org/securing-apps/overview
