# Lab 04 — Operator on OpenShift / Kubernetes

## Objectif
Déployer Keycloak de manière déclarative avec les briques minimum de plateforme.

## Ordre conseillé
```bash
kubectl apply -f manifests/operator/namespace.yaml
kubectl apply -f manifests/secrets-examples/keycloak-db-secret.yaml
kubectl apply -f manifests/keycloak-cr/keycloak.yaml
kubectl apply -f manifests/monitoring/servicemonitor.yaml
kubectl apply -f manifests/network-policies/default-deny.yaml
kubectl apply -f manifests/network-policies/allow-ingress-and-monitoring.yaml
kubectl apply -f manifests/ingress/ingress.yaml
```

## Vérifications
```bash
kubectl get pods -n keycloak
kubectl get svc -n keycloak
kubectl get ingress -n keycloak
kubectl describe keycloak example-kc -n keycloak
```

## Contrôles fonctionnels
- accès console ;
- réponse health ;
- métriques ;
- état des pods ;
- logs propres.

## Extension
Ajouter un overlay `prod` avec :
- ressources ;
- anti-affinity ;
- PDB ;
- NetworkPolicy plus stricte ;
- stockage et sauvegarde DB.
