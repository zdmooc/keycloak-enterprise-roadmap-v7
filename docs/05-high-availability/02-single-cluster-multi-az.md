# Single Cluster Multi-AZ

## Objectif
Documenter la topologie généralement la plus réaliste pour un premier niveau entreprise.

## Quand elle est pertinente
- même région ;
- faible latence entre nœuds ;
- plateforme Kubernetes / OpenShift mature ;
- volonté de limiter la complexité par rapport au multi-cluster.

## Points clés
- plusieurs zones de disponibilité ;
- pods répliqués ;
- base robuste ;
- supervision et tests de perte de pod / zone ;
- stratégie réseau maîtrisée.
