#!/usr/bin/env bash

APP_DIR="/opt/termix"
BACKUP_DIR="/opt/termix-backups"

echo "Creating backup..."
mkdir -p "$BACKUP_DIR"
tar -czf "$BACKUP_DIR/update-$(date +%F).tar.gz" -C "$APP_DIR" data

docker compose -f "$APP_DIR/compose.yml" pull
docker compose -f "$APP_DIR/compose.yml" up -d

echo "Update complete."
