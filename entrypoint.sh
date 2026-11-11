#!/bin/sh
set -eu

: "${GRAFANA_URL:?GRAFANA_URL is required}"
: "${GRAFANA_TOKEN:?GRAFANA_TOKEN is required}"

export BACKUP_DIR="${GRAFANA_BACKUP_PATH}"
mkdir -p "${BACKUP_DIR}"

grafana-backup save

ls -lt "${BACKUP_DIR}"/*.tar.gz 2>/dev/null |
  tail -n +"$((GRAFANA_BACKUPS_TO_KEEP + 1))" |
  xargs -r rm -f --
