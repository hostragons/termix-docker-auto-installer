# 🚀 Termix Docker Auto Installer

Deploy **Termix SSH Manager** on Ubuntu in one command.

---

## ⚡ Quick Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hostragons/termix-docker-auto-installer/main/install.sh)
```

---

## ✨ Features

* One-command installation
* Docker-based setup
* Nginx reverse proxy
* Free SSL (Let's Encrypt)
* UFW firewall
* Fail2ban protection
* Daily automatic backups
* Auto updates (Watchtower)
* RDP / VNC support (guacd)
* SSH login branding

---

## 🔐 Requirements

* Ubuntu 22.04 / 24.04
* Root access
* Domain pointing to your server
* Ports 80 and 443 open

---

## 📦 Installed Stack

* Termix (latest)
* guacd (RDP support)
* Docker + Compose
* Nginx
* Certbot
* Fail2ban
* UFW
* Watchtower (auto updates)

---

## 🔄 Update

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hostragons/termix-docker-auto-installer/main/update.sh)
```

---

## 🧹 Uninstall

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hostragons/termix-docker-auto-installer/main/uninstall.sh)
```

---

## 📁 Default Paths

* App: `/opt/termix`
* Backups: `/opt/termix-backups`

---

## 🔎 SEO Keywords

termix installer, termix docker install, termix ubuntu setup, self hosted ssh manager, termix ssl setup, termix nginx, termix hosting, termix rdp setup

---

## 🏢 Branding

This installer adds an optional SSH login banner.

---

## 📜 License

## MIT

# ===========================

# install.sh

# ===========================

```bash
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
```

---

# ===========================

# update.sh

# ===========================

```bash
#!/usr/bin/env bash

APP_DIR="/opt/termix"
BACKUP_DIR="/opt/termix-backups"

echo "Creating backup..."
mkdir -p "$BACKUP_DIR"
tar -czf "$BACKUP_DIR/update-$(date +%F).tar.gz" -C "$APP_DIR" data

docker compose -f "$APP_DIR/compose.yml" pull
docker compose -f "$APP_DIR/compose.yml" up -d

echo "Update complete."
```

---

# ===========================

# uninstall.sh

# ===========================

```bash
#!/usr/bin/env bash

docker compose -f /opt/termix/compose.yml down || true

rm -rf /opt/termix
rm -rf /opt/termix-backups

rm -f /etc/nginx/sites-enabled/termix
rm -f /etc/nginx/sites-available/termix

systemctl restart nginx || true

rm -f /etc/update-motd.d/99-branding || true

echo "Uninstalled successfully."
```
