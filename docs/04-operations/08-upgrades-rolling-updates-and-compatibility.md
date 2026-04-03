# Upgrades, Rolling Updates and Compatibility

## Objectif
Préparer les mises à jour comme des changements maîtrisés, pas comme une improvisation de fin de sprint.

## Démarche recommandée
1. lire les release notes ;
2. lire le guide d’upgrade ;
3. exécuter `update-compatibility` ;
4. déterminer si la mise à jour peut être faite en rolling update ou nécessite un recreate ;
5. rejouer les tests de base ;
6. déposer les preuves.

## Jeu minimal de tests post-upgrade
- connexion utilisateur ;
- login admin ;
- token issuance ;
- logout ;
- metrics ;
- health ;
- client critique ;
- service account critique.

## Erreurs fréquentes
- supposer que toutes les mises à jour peuvent être rolling ;
- négliger les impacts des providers, thèmes ou fonctionnalités activées ;
- sauter la lecture des migration changes.
