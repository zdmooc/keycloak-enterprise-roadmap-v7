# Identity Brokering

## Objectif
Brancher Keycloak sur des fournisseurs d’identité externes et l’utiliser comme **broker central**.

## Cas d’usage
- SSO entre applications internes et IDP externe ;
- intégration Azure AD, Google, GitHub, SAML corporate ;
- stratégie “Keycloak front door” ;
- B2E ou B2B avec fédération.

## Principes
Le brokering règle l’authentification déléguée.  
Il ne remplace pas à lui seul :
- la gouvernance des utilisateurs ;
- la qualité des claims ;
- la stratégie de mapping ;
- la sécurité des clients.

## Décisions clés
### 1. Source d’identité
- IDP social ;
- IDP corporate OIDC ;
- IDP corporate SAML ;
- plusieurs IDP selon population.

### 2. Provisioning
- création Just-In-Time ;
- lien manuel ;
- lien automatique ;
- règles de mapping et de fusion.

### 3. Attributs et rôles
Définir précisément :
- quels attributs sont consommés ;
- quelles valeurs font foi ;
- comment mapper les groupes / rôles ;
- quelle source est autoritaire.

## Pattern recommandé
- Keycloak comme point d’entrée unique ;
- mappings minimaux et documentés ;
- stratégie de linking claire ;
- tests de logout, refresh token, consentement, MFA et erreurs.

## Erreurs fréquentes
- supposer que tous les IDP exposent les mêmes claims ;
- négliger la gestion du logout ;
- accepter des redirections ou domaines trop larges ;
- ne pas vérifier les groupes réellement émis par l’IDP.

## Checklist
- [ ] protocole OIDC ou SAML choisi
- [ ] mapping des claims documenté
- [ ] stratégie de linking arrêtée
- [ ] logout et erreurs testés
- [ ] parcours MFA clarifié

## Références officielles
- https://www.keycloak.org/docs/latest/server_admin/index.html
- https://www.keycloak.org/docs/latest/securing_apps/index.html
