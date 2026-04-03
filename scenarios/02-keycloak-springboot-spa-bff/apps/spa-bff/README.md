# SPA + BFF

## Idée
Le navigateur parle au BFF avec un cookie de session.  
Le BFF parle à Keycloak et à l’API.  
Le navigateur n’a pas besoin de manipuler directement un refresh token longue durée.

## Contrat minimal
- cookie `HttpOnly`
- `SameSite` choisi selon le besoin
- CSRF traité
- token access transmis côté serveur uniquement quand possible
