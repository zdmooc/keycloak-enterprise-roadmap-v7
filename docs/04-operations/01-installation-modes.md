# Installation Modes

## Objectif
Comprendre les modes de déploiement pour choisir un socle adapté au besoin.

## Modes usuels
- local single node pour apprentissage ;
- container / compose pour intégration simple ;
- Kubernetes / OpenShift via Operator pour industrialisation ;
- topologies HA avec base managée et observabilité intégrée.

## Choix par maturité
- **lab perso** : compose ou cluster local ;
- **POC équipe** : cluster simple, DB dédiée, metrics, ingress ;
- **prod** : Operator, base robuste, politiques réseau, sauvegardes, monitoring, runbooks, preuves de tests.

## Règle
Ne confonds pas “ça démarre” avec “c’est opérable”.
