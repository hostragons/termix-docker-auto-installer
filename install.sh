#!/usr/bin/env bash
set -Eeuo pipefail

echo "🚀 Termix Installer Starting..."

read -rp "Enter domain (example.com): " DOMAIN
read -rp "Enter email for SSL: " EMAIL

APP_DIR="/opt/termix"
BACKUP_DIR="/opt/termix-backups"
PORT="8080"

apt update -y
apt install -y curl nginx ufw fail2ban certbot python3-certbot-nginx docker.io docker-compose-plugin

systemctl enable docker
systemctl start docker

mkdir -p "$APP_DIR/data"

cat > "$APP_DIR/compose.yml" <<EOF
services:
  termix:
    image: ghcr.io/lukegus/termix:latest
    container_name: termix
    restart: unless-stopped
    ports:
      - "127.0.0.1:$PORT:8080"
      - "30001-30006:30001-30006"
    volumes:
      - $APP_DIR/data:/app/data

  guacd:
    image: guacamole/guacd:latest
    container_name: guacd
    restart: unless-stopped

  watchtower:
    image: containrrr/watchtower:latest
    container_name: watchtower
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    command: --cleanup --interval 3600
EOF

docker compose -f "$APP_DIR/compose.yml" up -d

cat > /etc/nginx/sites-available/termix <<EOF
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        proxy_pass http://127.0.0.1:$PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

ln -sf /etc/nginx/sites-available/termix /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

nginx -t
systemctl restart nginx

ufw allow 22
ufw allow 80
ufw allow 443
ufw --force enable

certbot --nginx -d "$DOMAIN" --non-interactive --agree-tos -m "$EMAIL"

mkdir -p "$BACKUP_DIR"

cat > /usr/local/bin/termix-backup.sh <<'EOF'
#!/bin/bash
tar -czf /opt/termix-backups/backup-$(date +%F).tar.gz /opt/termix/data
EOF

chmod +x /usr/local/bin/termix-backup.sh
echo "0 3 * * * root /usr/local/bin/termix-backup.sh" > /etc/cron.d/termix-backup

cat > /etc/update-motd.d/99-branding <<'EOF'
#!/usr/bin/env bash
echo ""
echo "====================================="
echo "   Powered by Hostragons Hosting 🚀"
echo "   https://hostragons.com"
echo "====================================="
echo ""
EOF

chmod +x /etc/update-motd.d/99-branding

echo ""
echo "✅ Installation completed!"
echo "🌐 https://$DOMAIN"
