#!/usr/bin/env bash

set -euo pipefail

# Vars
DESTINATION_DIRECTORY="/destination"
TIMESTAMP="$(date +"%Y-%m-%d_%H-%M-%S.%3N_%Z")"
FILEPATH="${DESTINATION_DIRECTORY}/postgres-${TIMESTAMP}.dump"

# Validation
[[ -d "$DESTINATION_DIRECTORY" ]]

# Execute
PGPASSWORD="$POSTGRES_PASSWORD" pg_dump \
  --host "$POSTGRES_HOST" \
  --username "$POSTGRES_USER" \
  --dbname "$POSTGRES_DB" \
  --format "custom" \
  --file "$FILEPATH"

# Output
destination_size="$(du -sb "$DESTINATION_DIRECTORY" | awk '{printf "%.2fgb\n", $1/1024/1024/1024}')"
log_timestamp="$(date +"%Y-%m-%d %H:%M:%S.%3N %Z")"
echo "[${log_timestamp}] [INFO] ${DESTINATION_DIRECTORY} -- ${destination_size}"

# Retention policy
find "$DESTINATION_DIRECTORY" -name '*.dump' -mtime +14 -delete
