# 07 Kubernetes Service Account Trust

## Objectif
Remplacer ou réduire l’usage des secrets statiques de clients confidentiels en s’appuyant sur l’identité native du cluster Kubernetes.

## Pourquoi c’est important
Les secrets statiques de clients OIDC sont pratiques mais deviennent une dette en production : fuite possible, rotation oubliée, duplication dans plusieurs namespaces ou pipelines.

## Pattern
- un workload Kubernetes possède un **service account** ;
- ce service account obtient un token projeté ;
- Keycloak peut utiliser ce token comme mécanisme d’authentification client selon les capacités récentes du produit ;
- le workload n’a plus besoin d’embarquer un secret client long terme.

## Cas d’usage
- opérateurs et contrôleurs ;
- microservices intra-cluster ;
- intégrations GitOps ou jobs batch ;
- clients machine-to-machine de courte durée.

## Gains
- réduction des secrets statiques ;
- meilleur alignement avec le modèle d’identité Kubernetes ;
- rotation naturelle des tokens projetés.

## Points d’attention
- cette approche reste à cadrer finement côté plateforme ;
- il faut documenter qui émet, qui vérifie et quelle audience est attendue ;
- ne pas mélanger identité de pod, identité de service account et identité métier sans design clair.

## Checklist
- [ ] service account dédié
- [ ] RBAC minimal
- [ ] audience et issuer connus
- [ ] client Keycloak documenté
- [ ] rotation / durée de vie validée

## Références officielles
- Keycloak release notes 26.4 / 26.5
- Keycloak server administration guide
