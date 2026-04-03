# Groups vs Roles vs Client Roles

## Objectif
Utiliser le bon objet au bon endroit.

## Règle simple
- **Groupes** : structure, appartenance, héritage organisationnel.
- **Realm roles** : privilèges transverses au realm.
- **Client roles** : droits propres à un client.

## Décision rapide
Utilise un **groupe** quand :
- tu veux représenter une unité, un périmètre, une tribu, une entité, un partenaire ;
- tu veux réutiliser une structure d’appartenance ;
- tu veux appliquer des droits à une population.

Utilise un **realm role** quand :
- le privilège est global au realm ;
- plusieurs clients ou plusieurs flows doivent le comprendre.

Utilise un **client role** quand :
- le droit n’a de sens que pour une application précise ;
- tu veux éviter de polluer l’espace global des rôles.

## Erreurs fréquentes
- mettre toute la logique métier dans les groupes ;
- créer des client roles pour des capacités globales ;
- utiliser les attributs utilisateur à la place des groupes ;
- mélanger rôles de support, rôles métier et rôles applicatifs.

## Méthode de revue
Pour chaque objet créé, documenter :
- pourquoi ce n’est pas un autre type d’objet ;
- qui l’administre ;
- où il est consommé ;
- quelle preuve d’usage existe.
