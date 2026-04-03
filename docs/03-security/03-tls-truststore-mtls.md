# TLS, Truststore and mTLS

## Objectif
Encadrer les flux chiffrés entrants et sortants, et savoir quand introduire du mTLS.

## Flux à distinguer
- navigateur / client → reverse proxy ;
- reverse proxy → Keycloak ;
- Keycloak → base de données ;
- Keycloak → LDAP / IdP / services externes ;
- clients machine-to-machine → Keycloak.

## Bonnes pratiques
- documenter quel composant termine TLS ;
- gérer les certificats et les AC de confiance explicitement ;
- traiter séparément le truststore pour les connexions sortantes ;
- éviter de supposer que “TLS existe quelque part”, sans savoir où.

## Quand utiliser mTLS
mTLS a du sens surtout pour :
- des clients confidentiels fortement contrôlés ;
- des flux inter-systèmes sensibles ;
- des environnements réglementés ;
- des patterns zero trust plus stricts.

## Points de contrôle
- chaîne de certificats valide ;
- rotation documentée ;
- truststore versionné ;
- monitoring des expirations ;
- plan de renouvellement.
