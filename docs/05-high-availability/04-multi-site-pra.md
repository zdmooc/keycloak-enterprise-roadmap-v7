# Multi-Site / PRA

## Current interpretation

PRA is a business continuity problem, not just a Keycloak replica-count problem.

For current upstream Keycloak, new studies should start from the supported 26.8 multi-cluster v2/stateless direction rather than designing a new deployment around deprecated multi-cluster v1.

## Questions to decide

- active/passive, active/active or warm standby;
- RTO;
- RPO;
- database source of truth;
- DNS/LB failover;
- certificate and secret availability;
- capacity after site loss;
- realm/configuration governance;
- client/application retry behavior;
- recovery ordering of DB, Keycloak, ingress and downstream apps.

## Test plan

At minimum:
1. healthy baseline;
2. Keycloak pod loss;
3. cluster loss;
4. database primary loss;
5. network degradation/latency;
6. traffic failover;
7. authentication and token refresh;
8. return to normal operation.

## Evidence boundary

No multi-site or PRA claim is promoted without observed failover/recovery measurements.
