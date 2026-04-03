# Management Interface, Health and Metrics

## Objectif
Savoir distinguer le trafic métier du trafic de supervision.

## Principes
La management interface sert à exposer les endpoints d’exploitation comme `/health` et `/metrics`. Elle doit être traitée explicitement :
- quel port ;
- quelle exposition ;
- qui y accède ;
- comment on l’intègre à Prometheus et aux probes.

## Recommandations
- n’expose pas les endpoints de management plus largement que nécessaire ;
- filtre l’accès réseau ;
- différencie les usages de probe interne et de supervision externe ;
- garde des preuves simples : réponse health, scrape metrics, alertes de base.

## Contrôles
- health live ;
- health ready ;
- métriques disponibles ;
- scrape effectif ;
- liens avec dashboard et alertes.
