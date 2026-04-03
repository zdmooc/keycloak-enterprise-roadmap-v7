# Compare patterns

## Questions à trancher
- Cette application peut-elle valider un JWT ?
- A-t-on besoin d’un backend de session ?
- Quel est le niveau de risque si un token navigateur fuit ?
- Souhaite-t-on un mode strictement API ou un rendu côté serveur ?

## Conclusion type
- application métier web classique -> client OIDC côté serveur
- API métier -> resource server
- SPA exposée et sensible -> BFF
