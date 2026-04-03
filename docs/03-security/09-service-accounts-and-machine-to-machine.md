# Service Accounts and Machine-to-Machine

## Objectif
Traiter les clients techniques comme des identités à part entière.

## Principes
- un service account doit avoir un propriétaire ;
- ses scopes et audiences doivent être minimaux ;
- son secret ou mode d’authentification doit être revu périodiquement ;
- son usage doit être observable ;
- il doit être distinct d’un compte utilisateur détourné pour l’automatisation.

## Bon pattern
- un client par service ou par famille cohérente ;
- rôle technique explicite ;
- rotation planifiée ;
- journalisation des appels.

## Mauvais pattern
- partager un même secret entre plusieurs applications sans gouvernance ;
- laisser un service account avec des droits de realm admin ;
- utiliser un compte humain pour du machine-to-machine.
