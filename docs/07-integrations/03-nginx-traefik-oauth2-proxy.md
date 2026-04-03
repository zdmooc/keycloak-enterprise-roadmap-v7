# 03 NGINX Traefik oauth2-proxy

## Objectif
Protéger des applications sans réécrire l’authentification dans le code, via un reverse proxy ou un auth proxy.

## Quand utiliser
- application legacy difficile à modifier ;
- portail interne ou outil d’exploitation ;
- protection rapide d’une application HTTP existante ;
- transition entre ancien modèle d’auth et OIDC.

## Pattern 1 — oauth2-proxy + Keycloak OIDC
`oauth2-proxy` agit comme client OIDC, gère la redirection vers Keycloak, puis relaie la requête vers l’application amont.

### Points importants
- utiliser le provider **Keycloak OIDC** et non l’ancien provider Keycloak déprécié ;
- ajouter une **audience mapper** côté Keycloak pour que l’`aud` corresponde au `client_id` attendu par oauth2-proxy ;
- décider quels headers d’identité sont propagés vers l’amont ;
- protéger la communication proxy → backend si les données sont sensibles.

## Pattern 2 — Traefik ForwardAuth
Traefik délègue l’authentification à un service externe. En pratique, on le combine souvent avec oauth2-proxy ou un composant équivalent.

### À retenir
- ForwardAuth ne remplace pas par magie la logique OIDC ; il délègue simplement la décision d’accès ;
- il faut documenter les headers transmis à l’application ;
- l’application ne doit pas faire confiance à ces headers si elle est joignable sans passer par Traefik.

## Pattern 3 — NGINX `auth_request`
NGINX déclenche une sous-requête d’autorisation. Si la sous-requête retourne 2xx, l’accès est autorisé ; si elle retourne 401 ou 403, l’accès est refusé.

### Cas d’usage
- validation de session ou de jeton avant d’atteindre une application ;
- intégration avec un service d’authn/authorisation externe.

### Attention
- `auth_request` n’est pas un moteur IAM complet ;
- la conception des en-têtes et la non-exposition directe du backend sont essentielles.

## Choix recommandé
### Pour un produit peu modifiable
`Keycloak + oauth2-proxy + reverse proxy` est souvent le meilleur compromis.

### Pour une API moderne
ne pas surcharger le proxy : préférer **resource server** ou **gateway** avec validation explicite des tokens.

## Headers à traiter avec rigueur
- `X-Auth-Request-User`
- `X-Auth-Request-Email`
- `X-Auth-Request-Groups`
- `Authorization`
- tout header custom identitaire ou rôle

Toujours documenter :
- qui les injecte ;
- qui les consomme ;
- comment empêcher l’usurpation ;
- si le backend est isolé du réseau direct.

## Checklist
- [ ] backend inaccessible hors proxy
- [ ] provider OIDC choisi correctement
- [ ] audience mapper en place si oauth2-proxy
- [ ] cookies sécurisés (`Secure`, `HttpOnly`, `SameSite`) revus
- [ ] headers propagés listés et justifiés
- [ ] tests de boucle de redirection et de logout effectués

## Preuves attendues
- diagramme de flux navigateur → proxy → Keycloak → backend
- capture des headers injectés
- test d’accès direct au backend refusé

## Références officielles
- OAuth2 Proxy Keycloak OIDC: https://oauth2-proxy.github.io/oauth2-proxy/configuration/providers/keycloak_oidc/
- Traefik ForwardAuth: https://doc.traefik.io/traefik/middlewares/http/forwardauth/
- NGINX auth_request: https://nginx.org/en/docs/http/ngx_http_auth_request_module.html
