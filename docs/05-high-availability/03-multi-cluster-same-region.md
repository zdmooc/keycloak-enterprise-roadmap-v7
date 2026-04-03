# Multi-Cluster Same Region

## Objectif
Décrire une topologie plus complexe, utile lorsque la résilience exige plus qu’un seul cluster.

## Quand la considérer
- exigences de disponibilité fortes ;
- équipe plateforme mature ;
- besoin de compartimenter davantage le plan de contrôle du cluster ;
- capacité à gérer la complexité de synchronisation et d’exploitation.

## Règle
Ne pas adopter ce modèle uniquement pour “faire plus robuste sur le papier”. Il faut une vraie justification et des tests.
