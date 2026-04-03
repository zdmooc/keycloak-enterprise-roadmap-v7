# Skill Matrix — débutant à expert

## Débutant
Sait :
- créer un realm ;
- créer des utilisateurs et rôles ;
- sécuriser une application simple ;
- lancer Keycloak en local.

Preuves :
- lab compose local ;
- export JSON d’un realm ;
- note simple sur OIDC.

## Intermédiaire
Sait :
- distinguer rôles realm / client roles ;
- utiliser client scopes et protocol mappers ;
- intégrer LDAP ;
- configurer un reverse proxy ;
- activer health / metrics ;
- utiliser kcadm et l’Admin API.

Preuves :
- scripts d’admin ;
- integration Spring/SPA ;
- documentation reverse proxy.

## Senior
Sait :
- concevoir un modèle de realm exploitable ;
- gérer plusieurs familles de clients ;
- mettre en place des politiques de sécurité ;
- exploiter Keycloak avec PostgreSQL, monitoring et logs ;
- planifier un upgrade avec rollback ;
- expliquer les limites du multi-site.

Preuves :
- support matrix ;
- checklist prod ;
- runbooks ;
- dashboard.

## Expert
Sait :
- arbitrer single-cluster vs multi-cluster selon le risque réel ;
- industrialiser realms, clients et secrets ;
- diagnostiquer les incidents transverses proxy / DB / cache / réseau / certificat ;
- intégrer Keycloak dans une plateforme K8s/OpenShift et GitOps ;
- articuler sécurité, disponibilité, coût et exploitabilité ;
- cadrer PRA, benchmark et résilience.

Preuves :
- ADR ;
- benchmark ;
- journal de tests de panne ;
- architecture cible et runbooks validés.
