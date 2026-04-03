# Lab — Spring Boot Resource Server

## But
Protéger une API avec Spring Security en validant des JWT Keycloak.

## Étapes
1. Démarrer Keycloak et un realm `demo`.
2. Créer un client API avec audience attendue.
3. Démarrer l’application Spring Boot.
4. Tester un endpoint protégé sans token puis avec token.
5. Vérifier le comportement sur rôle insuffisant.

## Fichiers fournis
- `src/main/resources/application.yml`
- `src/main/java/com/example/security/SecurityConfig.java`
- `src/main/java/com/example/api/HelloController.java`

## Preuves attendues
- 401 sans token
- 200 avec token valide
- 403 avec rôle insuffisant
