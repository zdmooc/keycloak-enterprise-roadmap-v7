import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 5,
  duration: '30s',
};

export default function () {
  const url = 'http://localhost:8080/realms/master/protocol/openid-connect/token';
  const payload = 'grant_type=password&client_id=admin-cli&username=admin&password=changeit';
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
