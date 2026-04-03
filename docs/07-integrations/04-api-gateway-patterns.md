# 04 API Gateway Patterns

## Objectif
Positionner correctement Keycloak par rapport à une API Gateway sans mélanger authentification, autorisation métier et gestion du trafic.

## Répartition saine des responsabilités
### Keycloak
- authentifie utilisateurs et clients ;
- émet des jetons ;
- fournit endpoints OIDC et SAML ;
- porte certaines politiques IAM.

### API Gateway
- applique politiques d’accès à l’entrée ;
- gère routage, rate limiting, quotas, journaux, exposition, parfois validation de jeton.

### Backend métier
- reste autorité finale pour l’autorisation métier fine.

## Trois patterns fréquents
### Pattern A — Gateway valide le JWT, backend fait l’autorisation métier
Bon compromis dans beaucoup de SI.

### Pattern B — Gateway fait validation + quelques contrôles scope/rôle simples
Pertinent pour des APIs homogènes. Ne pas déplacer toute la logique métier dans la gateway.

### Pattern C — Gateway + token exchange / propagation contrôlée
Utile pour séparer identité externe et identité interne, mais plus complexe.

## Token propagation
Questions à trancher :
- propager le token utilisateur jusqu’au backend ?
- émettre un token interne ?
- faire un échange de jeton ?
- conserver l’identité originale dans un header signé ou tracé ?

## Recommandation
- commencer simple : **validation JWT + propagation contrôlée + autorisation métier côté API** ;
- n’utiliser token exchange que s’il y a un vrai besoin d’isolation ou de segmentation de confiance.

## Pièges fréquents
- mettre trop d’intelligence métier dans la gateway ;
- perdre la traçabilité de l’utilisateur final ;
- accepter n’importe quelle audience ;
- oublier que la gateway peut devenir point de panne critique.

## Checklist
- [ ] responsabilités clairement séparées
- [ ] audience et scopes par API définis
- [ ] stratégie de propagation documentée
- [ ] logs corrélés entre gateway et backend
- [ ] cas 401/403 et expiration testés

## Références officielles
- Keycloak securing apps overview: https://www.keycloak.org/securing-apps/overview
- Keycloak authorization services: https://www.keycloak.org/docs/latest/authorization_services/index.html
