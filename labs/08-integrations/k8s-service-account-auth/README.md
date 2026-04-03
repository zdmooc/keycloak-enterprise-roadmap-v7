# Lab — Kubernetes Service Account Auth

## But
Illustrer un pattern machine-to-machine moderne sans secret client statique long terme.

## Étapes conceptuelles
1. Créer un service account dédié.
2. Projeter son token dans le pod.
3. Configurer le client Keycloak pour accepter ce mécanisme.
4. Tester l’obtention d’un token selon le design retenu.

## Résultat attendu
Une note d’architecture précisant :
- pourquoi ce pattern est retenu ou non ;
- quels risques il réduit ;
- quels prérequis plateforme il impose.
