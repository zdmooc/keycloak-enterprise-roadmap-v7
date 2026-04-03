# Keycloak Enterprise Roadmap V7

Guide structuré et opérationnel pour apprendre, concevoir, industrialiser et exploiter **Keycloak** de zéro à un niveau **expert / architecte / production**.

## Ce que la V7 apporte
La V7 transforme le scénario principal `Keycloak + oauth2-proxy + Traefik + whoami` en **stack locale réellement exécutable** :

- import automatique d’un realm de démonstration ;
- client OIDC confidentiel déjà déclaré ;
- utilisateur de démonstration prêt à se connecter ;
- fichiers `.env`, `docker compose`, `Traefik`, tests et scripts de lancement ;
- procédure de validation pas à pas ;
- preuves attendues documentées dans le scénario.

Identifiants de démonstration du scénario V7 :
- **admin Keycloak** : `admin / adminadmin`
- **utilisateur** : `demo / demopass`

## Ce que la V6 apporte
La V6 ajoute des **scénarios intégrés de bout en bout** pour éviter un dépôt trop théorique.

Scénarios ajoutés :
- `scenarios/01-keycloak-oauth2-proxy-traefik-whoami/` : protection d’une application HTTP simple derrière Traefik + oauth2-proxy + Keycloak ;
- `scenarios/02-keycloak-springboot-spa-bff/` : comparaison entre un client web Spring Boot, un backend resource server et un pattern SPA + BFF ;
- `scenarios/03-keycloak-nginx-authrequest-legacy/` : protection d’une application legacy HTTP avec NGINX `auth_request` ;
- `scenarios/04-keycloak-k8s-serviceaccount-machine-auth/` : confiance entre workload Kubernetes et Keycloak pour du machine-to-machine.

La logique V6 est simple :
1. lire l’architecture ;
2. démarrer la stack locale ou appliquer les manifests ;
3. exécuter les tests ;
4. déposer les preuves dans `evidence/`.

## Cible
Ce dépôt s’adresse à quatre profils principaux :
- **débutant** qui veut comprendre IAM, OIDC, OAuth 2.0, SAML et la logique Keycloak ;
- **administrateur / intégrateur** qui veut configurer des realms, clients, rôles, groupes, fédérations et identity brokering ;
- **architecte** qui veut raisonner en termes de patterns, limites, sécurité, HA, PRA, support matrix et gouvernance ;
- **ops / SRE / plateforme** qui veut superviser, mettre à jour, benchmarker, durcir et opérer Keycloak sur Kubernetes / OpenShift.

## Ambition du dépôt
Ce dépôt ne cherche pas seulement à expliquer l’interface de Keycloak. Il vise à couvrir les trois niveaux qui distinguent un simple usage d’une vraie maîtrise :
1. **le fonctionnel IAM** : realms, clients, scopes, rôles, groupes, fédération, brokering, MFA, passkeys ;
2. **l’ingénierie plateforme** : reverse proxy, TLS, management interface, cache, base PostgreSQL, Operator, observabilité, upgrade ;
3. **le niveau entreprise** : multi-AZ, PRA, patterns B2E et B2B, runbooks, GitOps, preuves de tests, gouvernance et design decisions.

## Ce que le dépôt contient
- `docs/` : cours et guides structurés débutant → expert ;
- `labs/` : labs rejouables en local, via API, via Operator et sur cluster ;
- `manifests/` : exemples Kubernetes / OpenShift prêts à adapter ;
- `tools/` : scripts d’admin, d’export/import, de smoke tests et de benchmark ;
- `runbooks/` : procédures d’exploitation incident / changement ;
- `architecture/` : ADR, matrice de support, décisions de topologie ;
- `gitops/` : exemples Argo CD / Flux ;
- `evidence/` : emplacements pour résultats, captures, mesures et conclusions.

## Parcours conseillé
1. Lire `docs/learning-path.md`
2. Faire `labs/00-local-compose`
3. Enchaîner avec `labs/01-admin-api-and-kcadm`
4. Lire en priorité :
   - `docs/02-admin-and-realm-design/`
   - `docs/03-security/`
   - `docs/04-operations/`
   - `docs/05-high-availability/`
5. Rejouer en priorité le scénario exécutable V7 :
   - `scenarios/01-keycloak-oauth2-proxy-traefik-whoami/`
6. Faire ensuite le **lot intégrations** :
   - `docs/07-integrations/`
   - `labs/08-integrations/`
7. Rejouer enfin :
   - `labs/04-operator-openshift`
   - `labs/05-observability`
   - `labs/06-upgrade-and-failover`
   - `labs/07-benchmark`

## Références de départ
Voir `docs/references/official-index.md`.
