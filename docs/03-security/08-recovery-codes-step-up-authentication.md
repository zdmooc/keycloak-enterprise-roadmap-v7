# Recovery Codes and Step-up Authentication

## Objectif
Prévoir les chemins de secours et les exigences d’authentification renforcée.

## Recovery codes
Les recovery codes servent à :
- garder un chemin d’accès lorsque le facteur principal est indisponible ;
- éviter un support manuel systématique ;
- améliorer la résilience du parcours utilisateur.

Ils demandent cependant :
- une politique de distribution ;
- une politique de régénération ;
- des instructions utilisateur claires ;
- un contrôle d’exposition.

## Step-up authentication
La step-up authentication consiste à exiger un niveau d’authentification supérieur lorsqu’une action devient sensible.

Exemples :
- simple consultation → session standard ;
- validation d’opération critique → facteur supplémentaire ;
- accès admin → niveau d’assurance renforcé.

## Ce qu’il faut documenter
- déclencheurs ;
- niveau d’assurance attendu ;
- parcours utilisateur ;
- gestion des exceptions ;
- journalisation.
