# 05 SAML Service Provider Integration

## Objectif
Intégrer Keycloak avec une application ou un produit qui parle encore principalement SAML.

## Quand utiliser
- application d’entreprise ou produit tiers déjà certifié SAML ;
- environnement avec besoins de fédération historiques ;
- migration progressive vers OIDC non encore possible.

## Règle pratique
**Ne pas forcer OIDC partout** si l’application cible vit mieux en SAML aujourd’hui. Le bon design est celui qui réduit le risque et la dette, pas celui qui impose un protocole à tout prix.

## Éléments à cadrer
- SP initiated vs IdP initiated ;
- métadonnées SP ;
- ACS URL ;
- NameID ;
- mappage groupes/attributs ;
- durée de vie et logout ;
- signature et chiffrement si requis.

## Recommandation
- documenter précisément les attributs attendus par le SP ;
- figer une convention sur NameID ;
- éviter les assertions surchargées ;
- tester les cas d’horloge, logout et certificats expirés.

## Cas typiques
- application éditeur sans support OIDC moderne ;
- portail RH ou outillage d’exploitation ;
- transition d’un annuaire ou ADFS vers Keycloak.

## Pièges fréquents
- métadonnées non versionnées ;
- certificat de signature non anticipé ;
- mapping de groupes trop verbeux ;
- confusion entre rôles applicatifs et attributs SAML.

## Checklist
- [ ] SP metadata versionnée
- [ ] ACS et logout URLs testées
- [ ] certificats documentés
- [ ] attributs minimaux validés avec le SP
- [ ] stratégie de rollover certifiée côté exploitants

## Références officielles
- Keycloak securing apps overview: https://www.keycloak.org/securing-apps/overview
- Keycloak guides: https://www.keycloak.org/guides
