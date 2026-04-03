import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 5,
  duration: '30s',
};

const url = __ENV.TOKEN_URL || 'http://localhost:8080/realms/demo/protocol/openid-connect/token';
const clientId = __ENV.CLIENT_ID || 'demo-api';
const clientSecret = __ENV.CLIENT_SECRET || 'change-me';

export default function () {
  const payload = `grant_type=client_credentials&client_id=${clientId}&client_secret=${clientSecret}`;
  const params = {
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
  };
  const res = http.post(url, payload, params);
  check(res, {
    'status is 200': (r) => r.status === 200,
    'has access token': (r) => String(r.body).includes('access_token'),
  });
  sleep(1);
}
