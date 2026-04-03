# Operator on Kubernetes / OpenShift

## Objectif
Déployer Keycloak de manière plus industrialisée qu’un simple manifeste artisanal.

## Ce que l’Operator apporte
- modèle déclaratif ;
- gestion du cycle de vie ;
- simplification de certains changements ;
- intégration plus naturelle au cluster.

## Pré-requis de plateforme
- namespace dédié ;
- secret DB ;
- politique réseau ;
- exposition maîtrisée ;
- monitoring ;
- sauvegardes.

## Contrôles post-déploiement
- état de la ressource Keycloak ;
- pods Ready ;
- service ;
- ingress / route ;
- health ;
- metrics ;
- journaux propres ;
- tests de connexion.
