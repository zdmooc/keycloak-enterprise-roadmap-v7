# Support Matrix

## Objectif
Séparer clairement :
- ce qui est explicitement documenté et testé par les guides officiels ;
- ce qui est réaliste mais demande validation propre ;
- ce qui est expérimental ou trop coûteux pour un gain incertain.

## Catégories internes du dépôt
### A — support / documentation officielle claire
- single cluster à faible latence ;
- management interface, health, metrics ;
- upgrade avec vérification de compatibilité ;
- Operator sur Kubernetes / OpenShift.

### B — crédible mais à valider dans ton contexte
- multi-cluster même région ;
- PRA avec outillage et procédure spécifique ;
- patterns B2B / Organizations avec exigences propres.

### C — à traiter comme expérimental
- topologies très distribuées multi-régions sans preuve sérieuse ;
- patterns custom complexes non benchmarkés ;
- extension SPI introduite sans stratégie d’upgrade.
