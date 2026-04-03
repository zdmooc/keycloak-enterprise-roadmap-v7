# Fine-Grained Admin Permissions

## Objectif
Déléguer l’administration sans donner un pouvoir global excessif sur tout le realm.

## Quand utiliser
- plusieurs équipes doivent gérer des clients différents ;
- le support doit consulter sans modifier ;
- une équipe sécurité gère certains objets ;
- l’ownership est réparti entre plateformes, applications et IAM.

## Principe
Le piège classique est de donner trop vite des droits de type `realm-admin`.  
À la place, on cherche un **modèle de délégation** :

- qui administre le realm ;
- qui administre certains clients ;
- qui gère les utilisateurs ou groupes ;
- qui gère les rôles ;
- qui a un accès lecture seule.

## Modèle recommandé

### 1. Cercle plateforme
Responsable :
- des paramètres structurants du realm ;
- des flows globaux ;
- des providers ;
- du thème ;
- des politiques communes ;
- de la production.

### 2. Cercle intégration applicative
Responsable :
- de ses clients ;
- de ses redirect URIs ;
- de ses scopes ;
- de ses secrets ;
- de la documentation d’intégration.

### 3. Cercle support / exploitation
Responsable :
- de la consultation ;
- de l’analyse des incidents ;
- de l’extraction de preuves ;
- éventuellement d’actions limitées et tracées.

## Démarche
1. classer les objets d’administration ;
2. identifier les propriétaires ;
3. créer des rôles d’administration par domaine ;
4. limiter les droits aux objets utiles ;
5. documenter les cas d’escalade ;
6. tester la délégation sur un realm de non-prod.

## Bonnes pratiques
- préférer des rôles d’admin **par usage** ;
- documenter qui peut créer/modifier/supprimer ;
- journaliser les changements sensibles ;
- éviter l’usage quotidien d’un compte super-admin ;
- garder une procédure d’accès de secours.

## Erreurs fréquentes
- donner `realm-admin` à toute l’équipe ;
- ne pas distinguer administration fonctionnelle et exploitation ;
- ne pas tracer l’ownership des clients ;
- mélanger droits permanents et droits exceptionnels.

## Checklist
- [ ] matrice des rôles d’administration rédigée
- [ ] comptes de secours documentés
- [ ] procédure d’escalade définie
- [ ] rôles de lecture seule disponibles
- [ ] tests de non-régression réalisés

## Références officielles
- https://www.keycloak.org/docs/latest/server_admin/index.html
- https://www.keycloak.org/docs-api/latest/rest-api/index.html
