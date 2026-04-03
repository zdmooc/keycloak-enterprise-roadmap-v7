# 01 Spring Boot OIDC

## Objectif
Sécuriser un backend Spring Boot avec Keycloak sans dépendre d’un adaptateur historique spécifique, en s’appuyant sur les mécanismes standards Spring Security.

## Quand utiliser
- API REST exposée à des frontends ou à d’autres services.
- Backend métier qui doit vérifier des JWT émis par Keycloak.
- Application MVC ou serveur web qui doit agir comme **OAuth2 client** pour déclencher une authentification utilisateur.

## Prérequis
- Realm Keycloak opérationnel.
- Client OIDC créé côté Keycloak.
- Compréhension minimale des claims `iss`, `aud`, `azp`, `scope`, `realm_access`, `resource_access`.

## Deux patterns à distinguer
### Pattern A — Resource Server JWT
L’application **ne déclenche pas le login**. Elle reçoit un bearer token, vérifie sa signature et ses claims, puis décide l’autorisation.

**À utiliser pour :** API derrière SPA, gateway, BFF, mobile app ou autre backend.

### Pattern B — OAuth2 Client / Login
L’application redirige l’utilisateur vers Keycloak, récupère le code d’autorisation, échange le code contre des jetons puis maintient une session applicative.

**À utiliser pour :** application web serveur traditionnelle, console d’admin, portail interne.

## Design recommandé
### Pour une API
- privilégier **Resource Server JWT** ;
- mapper les rôles Keycloak vers des autorités Spring de façon explicite ;
- refuser les tokens dont l’`aud` ne correspond pas au client ou à l’audience prévue ;
- documenter si l’API accepte JWT only ou introspection d’opaque token.

### Pour une application web serveur
- utiliser `oauth2Login()` et une session locale applicative ;
- séparer l’authentification utilisateur des appels backend-to-backend ;
- éviter de transformer l’application en pseudo-gateway.

## Points d’attention
- Les rôles Keycloak ne deviennent pas automatiquement des rôles Spring utilisables proprement ; il faut généralement un convertisseur de claims.
- Beaucoup d’équipes oublient l’`aud` et valident uniquement la signature : c’est insuffisant.
- Une API ne doit pas accepter sans revue un token prévu pour un autre client.

## Exemple minimal — `application.yml`
```yaml
spring:
  security:
    oauth2:
      resourceserver:
        jwt:
          issuer-uri: http://localhost:8080/realms/demo
```

## Exemple minimal — principe de conversion des rôles
- lire `realm_access.roles`
- lire `resource_access.<client>.roles`
- préfixer ou normaliser les valeurs dans Spring (`ROLE_` ou `SCOPE_` selon la stratégie retenue)
- documenter les conventions de nommage

## Décision d’architecture utile
### JWT localement validé
**Avantages**
- très performant ;
- moins de dépendance réseau ;
- bien adapté aux API à fort trafic.

**Inconvénients**
- révocation plus indirecte ;
- dépendance à la gestion correcte des durées de vie de jetons.

### Opaque token / introspection
**Avantages**
- contrôle plus central ;
- utile pour certains environnements réglementés.

**Inconvénients**
- appel réseau supplémentaire ;
- latence et dépendance accrues.

## Checklist
- [ ] client OIDC correctement catégorisé (public vs confidential)
- [ ] redirect URIs strictes pour le mode login
- [ ] audience documentée
- [ ] mapping des rôles/claims défini
- [ ] endpoints publics explicitement listés
- [ ] stratégie JWT vs introspection justifiée
- [ ] tests 401/403 présents

## Preuves attendues
- capture du client Keycloak
- `curl` sur endpoint protégé sans token puis avec token
- test de rôle insuffisant
- trace montrant le mapping d’autorités

## Références officielles
- Keycloak securing apps: https://www.keycloak.org/securing-apps/overview
- Keycloak OIDC endpoints: https://www.keycloak.org/securing-apps/oidc-layers
- Spring Security Resource Server JWT: https://docs.spring.io/spring-security/reference/servlet/oauth2/resource-server/jwt.html
