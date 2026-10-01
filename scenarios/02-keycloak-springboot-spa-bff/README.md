# Scenario 02 — Spring Boot / SPA / BFF architecture reference

## Status

**REFERENCE / NOT_EXECUTABLE_END_TO_END**

This directory currently illustrates three integration patterns:
- server-side OIDC web client;
- JWT resource server;
- SPA + BFF.

The compose file still uses lightweight placeholder services for the application components. Therefore this scenario must not be presented as a completed Spring Boot/BFF runtime.

## Architecture intent

```text
A. Browser -> server-side OIDC client -> Keycloak
B. SPA -> BFF -> Resource API
C. API client -> JWT Resource Server -> Keycloak JWKS
```

## What is useful today

- Spring Security configuration examples;
- application configuration examples;
- architecture trade-offs;
- comparison of token/session exposure.

## Missing before promotion

- real compiled Spring Boot applications;
- real BFF session/cookie handling;
- realm/client provisioning;
- integration tests;
- runtime evidence.

Until then the scenario remains architecture/reference content.
