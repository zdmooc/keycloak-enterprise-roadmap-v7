# Scenario 01 manifests

Ce dossier contient les artefacts Kubernetes / Traefik liés au scénario 01.

La V7 se concentre surtout sur la version **docker compose exécutable**.
La variante Kubernetes locale peut être ajoutée ensuite sur Kind, K3d ou OpenShift Local en réutilisant :
- le realm `realm/demo-realm.json` ;
- le pattern Traefik -> oauth2-proxy -> application ;
- les mêmes URLs fonctionnelles.

Priorité V7 : démonstration locale rapide et reproductible.
