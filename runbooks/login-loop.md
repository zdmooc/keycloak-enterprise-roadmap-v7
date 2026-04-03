# Runbook — boucle de redirection

## Symptômes
- page qui recharge sans fin ;
- retour au login après authentification ;
- callback qui échoue.

## Causes probables
- hostname ou proxy mal configuré ;
- schéma HTTP/HTTPS incohérent ;
- redirect URI incorrecte ;
- cookies / domaine / path incohérents.

## Vérifications
1. vérifier hostname et proxy headers ;
2. vérifier les redirect URIs du client ;
3. inspecter les en-têtes proxy ;
4. consulter logs Keycloak et proxy.

## Sortie attendue
Une cause clairement identifiée parmi :
- configuration Keycloak ;
- configuration proxy ;
- configuration client.
