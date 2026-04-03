# Invalid Redirect Uri

## Symptôme
Erreur de redirect URI invalide.

## Vérifications immédiates
- version déployée ;
- reverse proxy / ingress ;
- health et metrics ;
- événements récents ;
- changements de configuration ;
- logs d’application et d’ingress.

## Causes probables
- mauvaise configuration ;
- régression suite à upgrade ;
- secret / certificat / rotation ;
- mapping incorrect ;
- indisponibilité de dépendance externe.

## Réponse
1. sécuriser le périmètre ;
2. capturer les preuves ;
3. vérifier la cause la plus probable ;
4. appliquer le correctif minimal ;
5. valider le retour au nominal ;
6. ouvrir une action préventive.

## Preuves
- logs
- captures
- horodatage
- version
- manifeste ou configuration impactée
