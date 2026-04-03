# kcadm et Admin REST API

## Objectif
Administrer Keycloak de manière scriptée, reproductible et traçable.

## Pourquoi c’est indispensable
L’admin manuelle via console suffit pour apprendre.  
Elle ne suffit pas pour :
- versionner les changements ;
- rejouer des créations de clients ;
- aligner plusieurs environnements ;
- automatiser des contrôles ;
- intégrer CI/CD ou GitOps.

## Deux outils complémentaires

### kcadm.sh
CLI fournie par Keycloak.  
Très pratique pour :
- prototyper ;
- administrer rapidement ;
- écrire des scripts Bash simples ;
- exécuter des commandes dans un conteneur.

### Admin REST API
Plus adaptée pour :
- outillage applicatif ;
- scripts Python / Go / Java ;
- intégration pipelines ;
- contrôles plus fins.

## Modèle recommandé
- `kcadm` pour les scripts opérationnels simples ;
- Admin REST API pour l’automatisation structurée ;
- export des objets importants dans Git ;
- séparation entre secret runtime et configuration versionnée.

## Flux d’automatisation minimal
1. authentification admin dédiée ;
2. création ou mise à jour du realm ;
3. création des rôles ;
4. création des groupes ;
5. création des scopes ;
6. création des clients ;
7. configuration des secrets ;
8. tests de fumée.

## Règles d’or
- ne pas dépendre de l’état manuel caché ;
- rendre les scripts rejouables ;
- éviter les appels non idempotents sans garde ;
- gérer les erreurs HTTP ;
- journaliser les changements.

## Exemple kcadm
```bash
/opt/keycloak/bin/kcadm.sh config credentials \
  --server http://localhost:8080 \
  --realm master \
  --user admin \
  --password changeit

/opt/keycloak/bin/kcadm.sh create realms -s realm=demo -s enabled=true
/opt/keycloak/bin/kcadm.sh create clients -r demo \
  -s clientId=my-api \
  -s enabled=true \
  -s protocol=openid-connect \
  -s publicClient=false \
  -s serviceAccountsEnabled=true
```

## Exemple REST API
```bash
TOKEN=$(curl -s -X POST "http://localhost:8080/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=admin" \
  -d "password=changeit" \
  -d "grant_type=password" \
  -d "client_id=admin-cli" | jq -r '.access_token')

curl -s -X GET "http://localhost:8080/admin/realms/demo/clients" \
  -H "Authorization: Bearer ${TOKEN}"
```

## Erreurs fréquentes
- utiliser des comptes humains pour l’automatisation ;
- oublier les différences d’ID internes vs noms visibles ;
- ne pas maîtriser les dépendances d’ordre ;
- ne pas contrôler l’existence préalable des objets.

## Checklist
- [ ] scripts rejouables
- [ ] secrets sortis du code
- [ ] export Git des objets importants
- [ ] tests smoke disponibles
- [ ] usage de `admin-cli` maîtrisé

## Références officielles
- https://www.keycloak.org/docs-api/latest/rest-api/index.html
- https://www.keycloak.org/docs/latest/server_admin/index.html
- https://www.keycloak.org/docs/latest/upgrading/index.html
