# Runbook — Auth proxy headers

## Symptôme
L’application reçoit des headers d’identité incohérents, absents ou falsifiables.

## Vérifications immédiates
1. Le backend est-il joignable directement sans passer par le proxy ?
2. Les headers entrants du client sont-ils nettoyés ou réécrits par le proxy ?
3. Les headers propagés sont-ils documentés et minimaux ?
4. Traefik / NGINX / oauth2-proxy ajoutent-ils exactement les mêmes noms de headers que ceux attendus ?

## Remédiations
- isoler le backend ;
- supprimer les headers entrants fournis par le client ;
- préfixer ou standardiser les headers d’identité ;
- revoir les exceptions de chemins publics.
