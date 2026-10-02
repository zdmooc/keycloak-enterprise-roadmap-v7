import http from 'k6/http';
import { check, fail, sleep } from 'k6';

export const options = {
  vus: 5,
  duration: '30s',
};

const baseUrl = __ENV.BASE_URL || 'http://localhost:8080';
const realm = __ENV.REALM || 'master';
const clientId = __ENV.CLIENT_ID || 'admin-cli';
const username = __ENV.USERNAME || 'admin';
const password = __ENV.PASSWORD;

if (!password) {
  fail('PASSWORD must be provided at runtime');
}

export default function () {
  const url = `${baseUrl}/realms/${realm}/protocol/openid-connect/token`;
  const payload = {
    grant_type: 'password',
    client_id: clientId,
    username,
    password,
  };
  const params = {
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
  };

  const res = http.post(url, payload, params);
  check(res, {
    'status is 200': (r) => r.status === 200,
    'contains access token': (r) => r.body.includes('access_token'),
  });
  sleep(1);
}
