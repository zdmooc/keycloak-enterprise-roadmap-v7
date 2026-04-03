# 02 Feature Watchlist

## Sujets à suivre en priorité
- **DPoP** : désormais officiellement supporté à partir de Keycloak 26.4, utile pour certains modèles de menace autour du rejeu de bearer tokens.
- **Workflows** : introduit en preview dans la série 26.4/26.5, prometteur pour des usages IGA et automatisation admin mais à traiter avec prudence.
- **Kubernetes service account tokens pour l’auth client** : très intéressant pour réduire les secrets statiques dans les workloads cluster.
- **JWT Authorization Grants** : alternative recommandée par Keycloak dans certains cas à l’external-to-internal token exchange.
- **Fine-Grained Admin Permissions V2** : important pour déléguer l’administration sans rôles trop puissants.

## Politique du dépôt
- fonctionnalités **stables** : documentées comme candidates sérieuses à l’adoption ;
- fonctionnalités **preview / expérimentales** : documentées avec avertissement, sans recommandation de généralisation par défaut ;
- nouveautés de release : vérifier à chaque montée de version si elles changent le design de référence.
