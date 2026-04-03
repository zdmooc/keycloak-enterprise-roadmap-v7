# User Profile and Attributes

## Objectif
Encadrer l’usage des attributs utilisateur et du user profile pour éviter la dérive de données.

## Bonne pratique
Traiter les attributs utilisateur comme un **contrat de données** :
- définition claire ;
- propriétaire ;
- source de vérité ;
- visibilité ;
- cycle de vie ;
- conformité.

## À documenter pour chaque attribut
- nom ;
- description ;
- source ;
- format ;
- obligatoire ou non ;
- exposition dans les tokens ;
- sensibilité ;
- règles de validation.

## Pièges
- utiliser des attributs libres pour contourner un vrai besoin de modélisation ;
- exposer trop d’attributs dans les tokens ;
- stocker des données non nécessaires à l’authentification ou à l’autorisation.
