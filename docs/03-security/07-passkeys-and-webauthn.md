# Passkeys and WebAuthn

## Objectif
Introduire le passwordless de manière progressive et gouvernée.

## Pourquoi ce sujet est stratégique
Les passkeys améliorent l’expérience utilisateur et renforcent la résistance au phishing, mais leur introduction demande une vraie préparation :
- support des navigateurs et postes ;
- stratégie d’enrôlement ;
- parcours de secours ;
- politique pour comptes sensibles.

## Démarche recommandée
1. commencer par un périmètre pilote ;
2. définir qui peut enrôler une passkey ;
3. documenter les parcours de perte d’appareil ;
4. vérifier la cohérence avec MFA et politiques existantes ;
5. mesurer l’adoption réelle.

## Décision de design
Les passkeys ne remplacent pas automatiquement tous les autres facteurs. Souvent, la bonne approche consiste à :
- démarrer sur une population interne ou pilote ;
- garder un mécanisme de secours ;
- revoir progressivement les flows d’authentification.
