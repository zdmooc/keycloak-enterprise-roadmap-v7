# Threats, Misconfigurations and Hardening Checklist

## Menaces fréquentes
- redirect URI trop large ;
- client public injustifié ;
- proxy headers non maîtrisés ;
- exposition excessive de la console d’admin ;
- claims inutiles dans les tokens ;
- secrets oubliés ;
- manque de runbook pour la rotation ;
- confusion entre realm roles et client roles.

## Checklist de durcissement
- [ ] URL publique canonique documentée
- [ ] reverse proxy et headers validés
- [ ] admin console protégée
- [ ] clients classés par typologie
- [ ] client policies définies
- [ ] rotation de secrets planifiée
- [ ] management interface cadrée
- [ ] observabilité activée
- [ ] sauvegarde et restore testés
- [ ] runbooks incidents disponibles
