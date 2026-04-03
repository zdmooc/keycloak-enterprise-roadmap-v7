# Lab — oauth2-proxy

## But
Protéger une application HTTP existante avec Keycloak OIDC via oauth2-proxy.

## Étapes
1. Créer un client confidentiel dans Keycloak.
2. Ajouter une audience mapper pour inclure le client dans `aud`.
3. Démarrer oauth2-proxy avec le fichier de configuration fourni.
4. Vérifier la redirection vers Keycloak.
5. Vérifier les headers propagés vers l’application amont.
