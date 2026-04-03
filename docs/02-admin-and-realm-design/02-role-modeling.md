# Role Modeling

## Objectif
Éviter la dérive classique des rôles en séparant clairement rôles métier, rôles techniques et rôles de clients.

## Approche recommandée
### 1. Distinguer trois niveaux
- **rôles métier** : ce que l’utilisateur a le droit de faire dans le domaine fonctionnel ;
- **rôles techniques de plateforme** : administration, exploitation, support ;
- **client roles** : rôles propres à une application ou à une API.

### 2. Garder une hiérarchie simple
Un modèle soutenable ressemble souvent à :
- groupes = “population / organisation / appartenance”
- rôles = “capacité / privilège”
- client roles = “contrat spécifique avec un client”

### 3. Éviter les rôles composites à l’aveugle
Les composites peuvent simplifier, mais ils peuvent aussi masquer la réalité du droit accordé. Utilise-les seulement lorsqu’ils reflètent un vrai agrégat stable.

## Exemples
### Mauvais exemple
- `ROLE_APP1_MANAGER_FULL`
- `ROLE_APP1_MANAGER_FULL_V2`
- `ROLE_APP1_MANAGER_FULL_TEST`

### Meilleur exemple
- realm role `business-manager`
- client role `invoice-api:read`
- client role `invoice-api:approve`
- groupe `finance/managers` qui porte les rôles nécessaires

## Questions à se poser
- ce rôle est-il compris par le métier ?
- ce rôle vit-il dans une seule application ?
- est-ce un attribut d’organisation ou un privilège ?
- comment prouver qui possède ce rôle aujourd’hui ?

## Checklist
- [ ] taxonomie de rôles documentée
- [ ] séparation rôle métier / technique / client
- [ ] composites limités aux cas justifiés
- [ ] ownership des rôles défini
- [ ] convention de nommage formalisée
