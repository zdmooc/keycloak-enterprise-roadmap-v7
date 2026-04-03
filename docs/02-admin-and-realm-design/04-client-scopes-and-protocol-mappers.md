# Client Scopes and Protocol Mappers

## Objectif
Maîtriser le contenu des tokens et éviter l’inflation des claims.

## Problème classique
Sans gouvernance, les tokens deviennent trop gros, trop bavards et hétérogènes :
- duplication de claims ;
- expositions inutiles ;
- compatibilité fragile entre applications ;
- difficulté à auditer ce qui sort réellement dans les tokens.

## Démarche recommandée
1. Définir un **socle minimal** de client scopes partagés.
2. Séparer :
   - scopes communs ;
   - scopes métier ;
   - scopes techniques ;
   - scopes spécifiques à un client.
3. Valider chaque mapper contre une vraie consommation applicative.

## Principes
- Un token ne doit pas être un mini-annuaire.
- N’ajoute pas un claim “au cas où”.
- Préfère des claims stables, bien nommés et documentés.
- Différencie clairement `access token`, `ID token` et `userinfo`.

## Checklist de revue d’un mapper
- [ ] qui consomme ce claim ?
- [ ] dans quel type de token doit-il apparaître ?
- [ ] peut-on le calculer côté application plutôt que l’émettre ?
- [ ] contient-il une donnée sensible ?
- [ ] la cardinalité peut-elle faire grossir fortement le token ?
