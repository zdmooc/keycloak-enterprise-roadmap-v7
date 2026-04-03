# 09 End-to-end scenarios

## Objectif
Passer d’une documentation orientée “patterns” à des **assemblages complets**.  
Un dépôt expert doit permettre de montrer non seulement *ce qu’il faut choisir*, mais aussi *comment les briques s’assemblent*.

## Scénarios fournis
### 1. Keycloak + oauth2-proxy + Traefik + whoami
Cas d’usage :
- portail interne ;
- application HTTP simple ;
- besoin de SSO rapide sans recoder l’application.

Résultat attendu :
- l’utilisateur arrive sur Traefik ;
- oauth2-proxy déclenche la redirection OIDC vers Keycloak ;
- après authentification, la requête est transmise à `whoami` ;
- les headers d’identité sont visibles côté amont ;
- l’accès direct au backend est interdit ou non exposé.

### 2. Keycloak + Spring Boot + SPA/BFF
Cas d’usage :
- application moderne ;
- distinction entre frontend, backend métier et couche d’authentification ;
- comparaison entre login côté serveur et pattern BFF.

Résultat attendu :
- un client web déclenche un login OIDC standard ;
- un backend resource server valide les JWT ;
- le pattern SPA + BFF limite l’exposition de jetons dans le navigateur.

### 3. Keycloak + NGINX `auth_request` + application legacy
Cas d’usage :
- application difficile à modifier ;
- besoin de mettre un garde-barrière en frontal ;
- transition progressive vers des standards OIDC.

Résultat attendu :
- NGINX appelle un endpoint de décision d’accès ;
- l’application legacy reçoit uniquement des requêtes déjà autorisées ;
- les en-têtes propagés sont documentés.

### 4. Workload Kubernetes + service account + client Keycloak
Cas d’usage :
- machine-to-machine sur cluster ;
- suppression ou réduction du secret statique ;
- intégration d’un job, d’un controller ou d’un microservice avec Keycloak.

Résultat attendu :
- un pod obtient un token Kubernetes ou une identité de workload ;
- Keycloak traite cette identité comme preuve du client ;
- les appels API se font sans secret longue durée embarqué.

## Méthode de démonstration
Pour chaque scénario, conserver la même trame :
1. **architecture cible**
2. **pré requis**
3. **variables**
4. **manifests ou compose**
5. **tests pas à pas**
6. **captures / preuves**
7. **limites et décisions**
8. **durcissement pour la prod**

## Critères de qualité
Un scénario intégré est jugé utile s’il répond aux questions suivantes :
- le pattern est-il reproductible en local ou sur cluster ?
- les flux réseau sont-ils clairs ?
- les headers, cookies et jetons sont-ils explicités ?
- les points de confiance sont-ils bornés ?
- sait-on expliquer pourquoi ce pattern est choisi et quand il ne faut pas l’utiliser ?

## Lien avec le reste du dépôt
- patterns : `docs/07-integrations/`
- sécurité : `docs/03-security/`
- ops : `docs/04-operations/`
- labs d’intégration : `labs/08-integrations/`
- scénarios complets : `scenarios/`

## Preuves attendues
- captures de login ;
- trace d’échange token ou code ;
- sortie `curl -I` ;
- sortie applicative montrant les headers utiles ;
- preuve d’échec en accès direct hors frontal ;
- conclusion d’architecture : pourquoi ce pattern a été retenu.
