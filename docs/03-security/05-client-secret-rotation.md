# Client Secret Rotation

## Objectif
Éviter que les secrets des clients confidentiels deviennent des dettes permanentes.

## Modèle de rotation
1. inventorier les clients avec secret ;
2. classer par criticité ;
3. définir une fréquence cible ;
4. tester la rotation en environnement inférieur ;
5. vérifier l’impact applicatif ;
6. tracer la date, le propriétaire et la preuve de rotation.

## Points d’attention
- savoir où le secret est stocké côté application ;
- connaître le délai de propagation ;
- vérifier les caches éventuels ;
- prévoir la coordination avec les équipes applicatives.

## Ce que le runbook doit contenir
- client concerné ;
- secret actuel / nouveau secret ;
- fenêtre de rotation ;
- commande / API utilisée ;
- test fonctionnel ;
- plan de retour arrière ;
- preuve de succès.
