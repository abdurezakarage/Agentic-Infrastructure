.PHONY: setup test spec-check docker-test clean

# Initialize environment
setup:
	uv sync
	uv pip install -e .

# Run tests
test:
	uv run pytest tests/ -v

# Run tests in Docker
docker-test:
	docker build -t chimera-test .
	docker run --rm chimera-test

# Validate specs against implementation
spec-check:
	uv run python scripts/validate_specs.py

# Code quality checks
lint:
	uv run --with ruff ruff check .
	uv run --with mypy mypy .

# Clean up
clean:
	rm -rf __pycache__ .pytest_cache .ruff_cache
	find . -name "*.pyc" -delete