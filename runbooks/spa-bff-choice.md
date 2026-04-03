# Runbook — Choix SPA vs BFF

## Question
Une nouvelle application front doit-elle utiliser une SPA publique avec tokens côté navigateur, ou un BFF ?

## Réponse courte
- niveau de sensibilité faible et équipe expérimentée côté front : SPA possible ;
- niveau de sensibilité moyen/élevé, besoin de contrôle, cookies et sécurité plus forte : BFF recommandé.

## Critères
- exposition internet ;
- confidentialité des données ;
- maturité front ;
- exigences logout/session ;
- présence d’APIs multiples ;
- besoin de masquer les tokens au navigateur.
