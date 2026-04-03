# Capacity Planning and Sizing

## Objectif
Préparer une plateforme capable d’absorber la charge réelle.

## Variables à considérer
- nombre d’utilisateurs ;
- pics de login ;
- flows interactifs vs machine-to-machine ;
- taille des tokens ;
- fréquence des refresh ;
- latence DB ;
- nombre de nœuds ;
- exigences RTO/RPO.

## Méthode
- commencer avec une hypothèse simple ;
- benchmarker ;
- observer ;
- ajuster ;
- documenter les limites connues.
