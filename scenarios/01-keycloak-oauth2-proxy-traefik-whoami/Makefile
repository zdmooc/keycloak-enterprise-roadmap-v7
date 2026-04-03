SHELL := /bin/bash

.PHONY: preflight up down logs smoke ps

preflight:
	./scripts/preflight.sh

up:
	./scripts/up.sh

down:
	./scripts/down.sh

logs:
	./scripts/logs.sh

smoke:
	./tests/smoke.sh

ps:
	docker compose --env-file .env -f compose/docker-compose.yml ps
