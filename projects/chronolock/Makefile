# Chronolock developer workflow
# Usage: make <target>  (run `make help` to see all targets)

.PHONY: help install dev-install test unit integration cov lint typecheck format check clean build

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## Install the package (editable) with runtime dependencies
	python -m pip install -e .

dev-install: ## Install the package with dev/test dependencies
	python -m pip install -e ".[dev]"

test: ## Run the full test suite (unit + integration)
	python -m pytest

unit: ## Run only unit tests
	python -m pytest -m unit

integration: ## Run only integration tests
	python -m pytest -m integration

cov: ## Run tests with coverage report
	python -m pytest --cov=chronolock --cov-report=term-missing

lint: ## Run ruff linter
	python -m ruff check .

typecheck: ## Run mypy static type checking
	python -m mypy src

format: ## Auto-format code with ruff
	python -m ruff format .

check: lint typecheck test ## Run all quality gates (lint + typecheck + test)

clean: ## Remove build/artifacts and caches
	rm -rf build dist *.egg-info .pytest_cache .mypy_cache .ruff_cache
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true

build: ## Build distributable packages
	python -m pip install --quiet build
	python -m build