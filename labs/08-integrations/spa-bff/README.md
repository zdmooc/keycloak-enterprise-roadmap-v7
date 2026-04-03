# Lab — SPA + BFF

## But
Montrer comment réduire l’exposition des tokens dans le navigateur en déplaçant la logique OIDC dans un Backend For Frontend.

## Architecture
- navigateur → BFF
- BFF → Keycloak (Authorization Code Flow)
- BFF → API interne avec token utilisateur propagé ou token échangé selon le besoin

## Décisions à prendre
- cookie de session du BFF
- CSRF
- SameSite
- logout local et global
- propagation du contexte utilisateur

## Résultat attendu
Une note d’architecture comparant ce pattern à une SPA pure.
