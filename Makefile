.PHONY: lint smoke

lint:
	./tools/lint/markdownlint.sh

smoke:
	./tools/smoke-tests/check-health.sh
	./tools/smoke-tests/check-login-endpoints.sh
