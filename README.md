# Keycloak Enterprise Roadmap V7

Référentiel spécialiste **Keycloak / IAM / OIDC / OAuth 2.0 / SAML** du portfolio.

## Statut

**O6 COMPLETE — STATIC_VALIDATED + CI_RUNTIME_PROVEN_CONTAINER_KEYCLOAK + CRC_SHARED_IDENTITY_BOOTSTRAP_PROVEN (bounded subset)**

## Rôle canonique

Ce dépôt porte la profondeur Keycloak/IAM :
- realms, clients, scopes, rôles et groupes ;
- OIDC/OAuth2/SAML ;
- brokering et fédération LDAP/AD ;
- sécurité et client policies ;
- Operator / CR Keycloak ;
- intégrations applicatives ;
- observabilité Keycloak ;
- upgrades, backup/restore, HA/DR ;
- labs, runbooks et preuves.

Il ne duplique pas :
- le lifecycle cluster : `k8s-openshift-cluster-factory` ;
- les services techniques communs : `shared-platform-services-openshift` ;
- l'expertise GitOps générique : `argocd-expert-pack`.

## Baseline technique

Référence upstream actuelle du dépôt : **Keycloak 26.8.0**.

Les exemples Operator actifs utilisent `k8s.keycloak.org/v2beta1`.

Le parcours RHBK/OpenShift est suivi séparément de l'upstream via OperatorHub ; aucune équivalence automatique de version n'est supposée.

## Sécurité O6

Le dépôt est public.

Les fichiers de tokens générés qui existaient sous `labs-local/` ont été supprimés de l'arbre `main`. Leur présence historique implique qu'ils doivent être considérés comme divulgués ; supprimer un fichier de `main` ne réécrit pas l'historique Git.

Les surfaces actives n'embarquent plus :
- access/refresh tokens ;
- Kubernetes Secret contenant un mot de passe fixe ;
- bootstrap admin statique ;
- realm de scénario avec mot de passe/client secret concret.

Voir `SECURITY.md`.

## Runtime prouvé

Workflow Keycloak 26.8.0 container :
- readiness ;
- metrics ;
- OIDC discovery ;
- Admin API realm/client/user ;
- token `client_credentials` ;
- restart avec persistance du realm ;
- token valide après restart.

La preuve exacte est enregistrée sous `evidence/ci/O6-keycloak-runtime.md`.

CI statique de clôture avant le commit final O6 : `36878286683` = **SUCCESS** sur `a00afa635ad4a2e067f3b67bae29948d7662af5c`.

## OpenShift / CRC

Le parcours CRC/RHBK a désormais une **preuve bornée observée le 02/10/2026** via l'orchestration `shared-platform-services-openshift`, qui réutilise directement `install/01-crc-local/scripts/deploy-keycloak-crc.sh`.

Observé sur CRC 4.22.7 :
- RHBK Operator installé ;
- PostgreSQL lab Running ;
- Keycloak CR Ready ;
- pod Keycloak Running ;
- Route publique ;
- realm partagé `mayabank` créé/vérifié ;
- OIDC discovery valide.

Claim autorisé : `CRC_SHARED_IDENTITY_BOOTSTRAP_PROVEN`.

Cela **ne** promeut pas encore le spécialiste au niveau complet `CRC_RUNTIME_PROVEN_KEYCLOAK` : metrics, token issuance, restart persistence, upgrade, federation, backup/restore et HA doivent être rejoués/capturés explicitement sur CRC avant une telle promotion.

## Structure

```text
docs/          cours / architecture / security / ops / HA
labs/          labs progressifs
scenarios/     intégrations applicatives
manifests/     référence Operator/OpenShift
gitops/        contrat Keycloak spécifique
runbooks/      opérations
tools/         administration / tests
evidence/      claim/evidence
install/       labs CRC/Kind + références IaC/VM
```

## Commencer

1. `docs/learning-path.md`
2. `docs/11-feature-radar/CURRENT_BASELINE_2026-10-01.md`
3. `labs/00-local-compose`
4. `scenarios/01-keycloak-oauth2-proxy-traefik-whoami`
5. `labs/04-operator-openshift`

Les zones Terraform cloud et Ansible sont conservées comme **REFERENCE / REQUALIFICATION_REQUIRED**, pas comme preuve production.
