# Production Security Baseline

## Objectif
Définir le minimum de sécurité avant d’ouvrir une plateforme Keycloak à des applications réelles.

## Baseline minimale
- TLS en frontal ;
- reverse proxy et hostname correctement déclarés ;
- console d’admin non exposée plus largement que nécessaire ;
- secrets externalisés ;
- rotation planifiée ;
- sauvegardes testées ;
- logs et métriques activés ;
- health endpoints accessibles de manière contrôlée ;
- revue des flows et des redirect URIs ;
- ownership et procédures de changement.

## Politique par défaut
1. **Réduire la surface d’exposition**
   - exposition minimale des endpoints ;
   - filtrage réseau ;
   - séparation entre trafic applicatif et supervision.

2. **Réduire la confiance implicite**
   - pas de wildcard large sur les redirect URIs ;
   - pas de client public inutile ;
   - pas de scope par défaut trop généreux.

3. **Réduire les changements manuels**
   - script d’admin ;
   - export versionné ;
   - revues formelles.

## Revue de sécurité d’un client
- type de client ;
- flow autorisé ;
- secret / méthode d’authentification ;
- redirect URIs ;
- scopes ;
- audience ;
- propriétaires ;
- durée de vie des tokens ;
- mode de rotation.

## Checklist
- [ ] hostname cohérent
- [ ] reverse proxy validé
- [ ] admin console protégée
- [ ] endpoints de management cadrés
- [ ] secrets externalisés
- [ ] client policies définies
- [ ] runbooks sécurité disponibles
