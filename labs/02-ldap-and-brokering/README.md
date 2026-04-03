# Lab 02 — LDAP and Brokering

## Objectif
Préparer un lab réaliste de fédération et de brokering.

## Périmètre
- fédération LDAP / AD ;
- identity provider externe ;
- mapping groupes / rôles ;
- validation des claims et de l’expérience utilisateur.

## Étapes recommandées
1. déployer un annuaire de test ;
2. connecter Keycloak à l’annuaire ;
3. définir la stratégie d’import ou non-import ;
4. ajouter un identity provider broker ;
5. tester le mapping des identités ;
6. documenter les collisions de noms et cas de support.

## Points de vigilance
- ownership des comptes ;
- synchronisation ;
- mapping des groupes ;
- attributs ;
- résolution des doublons.
