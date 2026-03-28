#!/usr/bin/env bash

docker compose -f /opt/termix/compose.yml down || true

rm -rf /opt/termix
rm -rf /opt/termix-backups

rm -f /etc/nginx/sites-enabled/termix
rm -f /etc/nginx/sites-available/termix

systemctl restart nginx || true

rm -f /etc/update-motd.d/99-branding || true

echo "Uninstalled successfully."
