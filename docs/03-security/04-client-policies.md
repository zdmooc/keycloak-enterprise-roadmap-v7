# Client Policies

## Objectif
Standardiser la posture sécurité des clients au lieu de la laisser dériver au fil des projets.

## Ce que les client policies permettent
Les client policies et client profiles servent à exprimer :
- quelles familles de clients existent ;
- quels flows sont permis ;
- quelles contraintes sont obligatoires ;
- quelles exceptions sont tolérées.

## Taxonomie recommandée
- `spa-public`
- `backend-confidential`
- `machine-to-machine`
- `reverse-proxy-legacy`
- `external-partner`

Pour chacune, définir :
- mode d’authentification ;
- PKCE obligatoire ou non ;
- redirect URI policy ;
- méthode de client authentication ;
- durée de vie des tokens ;
- audience ;
- scopes autorisés.

## Modèle de contrôle
### SPA publique
- Authorization Code + PKCE
- pas de secret
- redirect URIs strictes
- scopes minimaux

### Backend confidentiel
- client authentication forte
- secret ou mécanisme alternatif approuvé
- scopes techniques limités
- ownership défini

### Machine-to-machine
- service accounts activés
- audience claire
- pas d’accès utilisateur si inutile
- politique de rotation formalisée

## Checklist
- [ ] taxonomie définie
- [ ] policies alignées avec les familles de clients
- [ ] exceptions revues
- [ ] ownership et date de revue
- [ ] preuve d’application dans un lab
