// Auteur : Zidane Djamal
// Description : Tests de charge k6 pour valider les performances de Keycloak.
// Scénario : Simulation de demandes de tokens (Client Credentials Grant) en parallèle.
// Exécution : k6 run --env KC_URL=https://keycloak.example.com k6-load-tests.js

import http from 'k6/http';
import { check, sleep } from 'k6';
import { Rate, Trend } from 'k6/metrics';

// Métriques personnalisées
const tokenRequestFailRate = new Rate('token_request_fail_rate');
const tokenRequestDuration = new Trend('token_request_duration_ms', true);

// Configuration du test
export const options = {
  stages: [
    { duration: '10s', target: 5  },  // Montée en charge progressive
    { duration: '20s', target: 10 },  // Charge nominale
    { duration: '10s', target: 0  },  // Descente progressive
  ],
  thresholds: {
    // Seuils de performance à ne pas dépasser
    'http_req_duration': ['p(95)<2000'],  // 95% des requêtes < 2 secondes
    'token_request_fail_rate': ['rate<0.05'],  // Moins de 5% d'échecs
    'http_req_failed': ['rate<0.05'],
  },
};

// Variables d'environnement (injectées par le pipeline CI/CD)
const KC_URL    = __ENV.KC_URL    || 'http://localhost:8080';
const KC_REALM  = __ENV.KC_REALM  || 'enterprise';
const CLIENT_ID = __ENV.KC_CLIENT_ID || 'backend-api';
const CLIENT_SECRET = __ENV.KC_CLIENT_SECRET || 'change-me';

const TOKEN_ENDPOINT = `${KC_URL}/realms/${KC_REALM}/protocol/openid-connect/token`;

export default function () {
  // Test 1 : Demande de token via Client Credentials Grant
  const tokenResponse = http.post(
    TOKEN_ENDPOINT,
    {
      grant_type:    'client_credentials',
      client_id:     CLIENT_ID,
      client_secret: CLIENT_SECRET,
    },
    {
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      tags:    { name: 'token_request' },
    }
  );

  const tokenSuccess = check(tokenResponse, {
    'Token endpoint status 200':    (r) => r.status === 200,
    'Response contient access_token': (r) => r.json('access_token') !== undefined,
    'Token type est Bearer':         (r) => r.json('token_type') === 'Bearer',
  });

  tokenRequestFailRate.add(!tokenSuccess);
  tokenRequestDuration.add(tokenResponse.timings.duration);

  // Test 2 : Vérification du document OIDC Discovery
  const discoveryResponse = http.get(
    `${KC_URL}/realms/${KC_REALM}/.well-known/openid-configuration`,
    { tags: { name: 'oidc_discovery' } }
  );

  check(discoveryResponse, {
    'OIDC Discovery status 200':       (r) => r.status === 200,
    'Discovery contient token_endpoint': (r) => r.json('token_endpoint') !== undefined,
    'Discovery contient jwks_uri':      (r) => r.json('jwks_uri') !== undefined,
  });

  sleep(1);
}
