#!/usr/bin/env bash
# Reset to initial state the database
set -euo pipefail
cd "$(dirname "$0")/.."

echo "→ Destroy the volume volume…"
docker compose down -v

echo "→ Restart…"
docker compose up -d

echo "→ Waiting for the database to be ready…"
until docker compose exec -T postgres pg_isready -U "${POSTGRES_USER:-olist}" >/dev/null 2>&1; do
  sleep 1
done

echo "→ Create raw tables…"
docker compose exec -T postgres psql -U olist -d olist -v ON_ERROR_STOP=1 -f /infra/ddl_raw.sql

echo "→ Load the CSV…"
docker compose exec -T postgres psql -U olist -d olist -v ON_ERROR_STOP=1 -f /infra/load_raw.sql

echo "✓ Database is ready."