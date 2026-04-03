# Runbook — échec de token exchange

## Symptômes
- 400 ou 403 sur le grant token exchange ;
- audience inattendue ;
- permissions insuffisantes.

## Vérifications
- feature activée ;
- client source ;
- client cible ;
- audience ;
- permissions d’échange.

## Actions
- revalider le design ;
- tester un cas minimal ;
- consigner la matrice source/cible/audience.
