import http from 'k6/http';
import { sleep, check } from 'k6';

export const options = {
  vus: 5,
  duration: '30s',
};

export default function () {
  const res = http.get('http://localhost:8080/');
  check(res, { 'status is 200 or 302': (r) => r.status === 200 || r.status === 302 });
  sleep(1);
}
