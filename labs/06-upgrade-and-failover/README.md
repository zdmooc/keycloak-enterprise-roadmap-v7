# Lab 06 — Upgrade and Failover

## Objectif
Valider qu’une installation est opérable lors d’un changement ou d’un incident.

## Parcours
### A. upgrade
1. lire la release cible ;
2. exécuter `update-compatibility` ;
3. déterminer rolling ou recreate ;
4. exécuter l’upgrade ;
5. jouer les tests post-upgrade.

### B. failover
1. supprimer un pod ;
2. mesurer l’impact ;
3. rejouer un login ;
4. observer les métriques ;
5. conclure.

### C. incident DB simulé
1. bloquer temporairement l’accès DB en environnement de test ;
2. observer le comportement ;
3. restaurer ;
4. vérifier la reprise.

## Preuves
- sortie `update-compatibility`
- chronologie de l’upgrade
- métriques avant / après
- conclusion sur la supportabilité
