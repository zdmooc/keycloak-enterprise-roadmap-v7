# High Availability Overview

## Objectif
Donner un vocabulaire commun avant de parler de topologie.

## Trois niveaux à distinguer
1. **disponibilité locale** : plusieurs pods dans un même cluster ;
2. **tolérance de panne zonale** : nœuds répartis sur plusieurs zones d’une même région à faible latence ;
3. **reprise après sinistre** : stratégie de bascule ou de reconstruction sur un autre site.

## Erreur classique
Employer “HA” pour désigner n’importe quelle duplication. La haute disponibilité utile suppose :
- un modèle clair de panne ;
- une latence compatible ;
- une base et un cache cohérents ;
- des tests de failover.
