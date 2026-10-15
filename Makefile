PYTHON ?= python3

.PHONY: docs docs-live docs-clean clean format format-check typecheck typecheck_pyright lint test test_fastfail audit

serve:
	python3 ./serve_dynamic.py

generate:
	python3 ./publish_static.py

serve_static: generate
	echo "Open:"
	echo "* http://localhost:8080/index.html"
	cd public && python3 -m http.server 8080

clean:
	find . -name "*.pyc" -print0 | xargs -0 rm -f
	find . -name "*~" -print0 | xargs -0 rm -f
	find . -name "__pycache__" -print0 | xargs -0 rm -rf

format:
	$(PYTHON) -m ruff check src tests --fix
	$(PYTHON) -m ruff format src tests

format-check:
	$(PYTHON) -m ruff format --check src tests

lint:
	$(PYTHON) -m ruff check src tests

typecheck_pyright:
	$(PYTHON) -m pyright

typecheck:
	$(PYTHON) -m mypy

test:
	$(PYTHON) -m pytest

test_fastfail:
	$(PYTHON) -m pytest -q -x

ci: format-check lint typecheck test_fastfail
