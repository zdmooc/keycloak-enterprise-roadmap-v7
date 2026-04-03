# PostgreSQL Best Practices

## Objectif
Traiter la base comme une dépendance structurante, pas comme un simple détail d’installation.

## Points à documenter
- version ;
- topologie ;
- haute disponibilité ;
- sauvegardes ;
- chiffrement ;
- supervision ;
- limites de connexions ;
- stratégie de maintenance ;
- ownership DBA / plateforme.

## Pièges
- sous-estimer la saturation des connexions ;
- ignorer la latence DB ;
- oublier de tester le restore ;
- ne pas corréler incidents Keycloak et incidents DB.
