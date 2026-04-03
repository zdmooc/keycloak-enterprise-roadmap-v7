# Organizations

## Objectif
Utiliser Organizations pour des cas **B2B** ou **B2B2C**, quand un même realm doit représenter des entités clientes, partenaires ou filiales.

## Pourquoi ce sujet est stratégique
Le modèle “un seul gros realm avec des groupes bricolés” atteint vite ses limites dès qu’il faut :

- inviter des membres externes ;
- distinguer plusieurs organisations ;
- gérer des administrateurs par organisation ;
- isoler la visibilité métier ;
- préparer des patterns CIAM.

## Quand choisir Organizations
Choisir Organizations quand vous avez :
- plusieurs entreprises partenaires ;
- des administrateurs propres à chaque organisation ;
- des processus d’invitation ou d’appartenance ;
- une logique multi-tenant fonctionnelle au sein d’un même realm.

## Quand ne pas choisir Organizations
Rester sur un design classique si :
- le besoin est purement interne et simple ;
- il n’existe pas de frontière organisationnelle métier forte ;
- vous cherchez seulement une segmentation technique.

## Modèle de décision
Posez quatre questions :

1. Les utilisateurs appartiennent-ils à des entités distinctes, visibles métier ?
2. Ces entités doivent-elles avoir des admins ou règles propres ?
3. Les parcours d’invitation / adhésion comptent-ils ?
4. Le B2B ou B2B2C est-il un axe durable de la plateforme ?

Si les réponses sont majoritairement oui, Organizations mérite un POC sérieux.

## Stratégie de mise en œuvre
1. démarrer par un POC isolé ;
2. définir la notion d’organisation côté métier ;
3. modéliser rôles globaux vs rôles par organisation ;
4. décider si le realm reste unique ou si plusieurs realms sont nécessaires ;
5. intégrer la gouvernance des invitations, membres, domaines et admins ;
6. mesurer les impacts UI, API, support et reporting.

## Ce qu’il faut documenter
- cycle de vie d’une organisation ;
- cycle de vie d’un membre ;
- permissions des admins d’organisation ;
- règles d’invitation ;
- naming convention ;
- impacts sur les applications.

## Risques
- sur-utiliser Organizations pour un besoin qui relève seulement des groupes ;
- sous-estimer les impacts UI / processus métier ;
- ne pas cadrer l’isolation logique des données côté applications.

## Checklist
- [ ] besoin B2B/B2B2C confirmé
- [ ] POC décidé
- [ ] modèle de rôles clarifié
- [ ] gouvernance invitation / appartenance définie
- [ ] impacts applicatifs documentés

## Références officielles
- https://www.keycloak.org/2024/06/announcement-keycloak-organizations
- https://www.keycloak.org/server/features
- https://www.keycloak.org/docs/latest/server_admin/index.html
