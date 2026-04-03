# Lab — Traefik ForwardAuth

## But
Déléguer la décision d’authentification à un service externe, typiquement oauth2-proxy.

## Vérifications
- Traefik transmet-il seulement les headers nécessaires ?
- L’application peut-elle être jointe sans passer par Traefik ?
- Les chemins de santé ou callbacks sont-ils traités explicitement ?
