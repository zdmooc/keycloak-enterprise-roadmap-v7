# Realm Design Principles

## Objectif
Définir une méthode de conception d’un realm qui reste maintenable au-delà du premier projet.

## Pourquoi ce sujet est critique
Dans Keycloak, un realm devient rapidement un mini-système d’information. Dès qu’on y met plusieurs applications, des rôles, des groupes, des mappings, des fédérations et des partenaires, les erreurs de design se payent très cher :
- explosion du nombre de rôles ;
- clients incohérents ;
- mappings opaques ;
- difficulté à déléguer l’administration ;
- incidents lors des changements.

## Principes de design
1. **Un realm n’est pas juste un dossier logique** : c’est un périmètre de sécurité, de gouvernance et d’administration.
2. **Le découpage par realm doit répondre à un vrai besoin** : séparation forte d’administration, différence réglementaire, isolation partenaire, ou politique d’authentification différente.
3. **Ne crée pas un realm par application** sans justification. Dans beaucoup de cas, plusieurs applications d’un même domaine métier peuvent partager un realm.
4. **Documente systématiquement la finalité du realm** : propriétaires, population, applications couvertes, contraintes, flux, dépendances.
5. **Prévois le run** : qui change quoi, comment on teste, comment on exporte, comment on revient arrière.

## Critères pour décider d’un nouveau realm
Créer un nouveau realm lorsque plusieurs de ces critères sont vrais :
- besoin d’isolation administrative forte ;
- jeux de rôles totalement différents ;
- fédérations différentes ;
- partenaires externes qui ne doivent pas voir les mêmes objets ;
- exigences de branding / UX / flows très distinctes ;
- besoin de séparation environnementale nette.

## Ce qu’il vaut mieux éviter
- un realm “poubelle” contenant tous les clients de l’entreprise ;
- un realm par équipe sans gouvernance ;
- un realm par microservice ;
- des conventions de nommage implicites ;
- des protocol mappers copiés/collés sans raison.

## Modèle de fiche de conception
Pour chaque realm, documenter :
- nom ;
- objectif ;
- type de population ;
- applications rattachées ;
- protocoles utilisés ;
- fédérations ;
- identity providers ;
- clients sensibles ;
- rôles structurants ;
- ownership ;
- politique de changement ;
- dépendances externes.

## Checklist
- [ ] finalité du realm explicitée
- [ ] critère de séparation documenté
- [ ] propriétaires identifiés
- [ ] convention de nommage définie
- [ ] politique d’export/import définie
- [ ] dépendances externes listées
- [ ] revue d’architecture tracée

## Références officielles
- https://www.keycloak.org/docs/latest/server_admin/index.html
- https://www.keycloak.org/server/configuration-production
