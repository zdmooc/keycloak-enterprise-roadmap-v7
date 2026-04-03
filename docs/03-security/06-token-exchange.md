# Token Exchange

## Objectif
Comprendre quand le token exchange résout un vrai besoin, et quand il complexifie inutilement l’architecture.

## Cas d’usage typiques
- un frontend obtient un token utilisateur, puis un backend doit appeler une API avec un autre audience ;
- une passerelle échange un token entrant contre un token adapté à un domaine cible ;
- délégation contrôlée entre services.

## Questions d’architecture
- quelle est l’identité de départ ?
- quel service effectue l’échange ?
- quelle audience cible veut-on produire ?
- l’API cible peut-elle accepter directement le token initial ?
- quel risque de sur-privilège introduit-on ?

## À ne pas faire
- utiliser le token exchange pour masquer un mauvais design de scopes ;
- multiplier les échanges sans traçabilité ;
- autoriser l’échange sur des clients trop larges.

## Contrôles minimaux
- clients autorisés à l’échange ;
- audiences explicites ;
- journalisation ;
- revue sécurité.
