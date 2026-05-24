# 🚀 Termix Auto Installer – Hostragons Edition

Professional one-command installer for **Termix Remote Desktop Platform** with Docker, Nginx reverse proxy, SSL automation, backups, Watchtower auto updates, firewall configuration and Hostragons branding.

Designed for:

- VPS servers
- Dedicated servers
- Cloud environments
- Remote desktop deployments
- Self-hosted terminal platforms
- Linux administrators
- Hosting providers

Supports Ubuntu, Debian, VPS environments and most modern Linux systems.

---

# ⚡ Quick Installation

Install instantly with one command:

```bash
bash <(curl -fsSL https://cdn.hostragons.com/storage/bash/hostragons_termix_installer.sh)
```

Update existing installation:

```bash
bash <(curl -fsSL https://cdn.hostragons.com/storage/bash/hostragons_termix_installer.sh) update
```

Uninstall:

```bash
bash <(curl -fsSL https://cdn.hostragons.com/storage/bash/hostragons_termix_installer.sh) uninstall
```

---

# 📌 What Does This Script Do?

This script automatically:

✔ Installs Docker

✔ Installs Docker Compose

✔ Installs Nginx

✔ Configures reverse proxy

✔ Installs SSL certificates automatically

✔ Configures UFW firewall

✔ Enables Fail2Ban

✔ Deploys Termix container

✔ Deploys Guacamole backend

✔ Deploys Watchtower automatic updates

✔ Creates automatic backups

✔ Creates scheduled cron jobs

✔ Adds Hostragons branding

✔ Runs Hostragons MOTD automatically

---

# 🔥 Features

---

## Docker Deployment

Automatically installs:

```text
Docker
Docker Compose
```

Creates:

```text
/opt/termix
```

Structure:

```text
/opt/termix
├── compose.yml
├── data
└── backups
```

---

## Automatic Reverse Proxy

Configures:

```text
Nginx
```

Automatically routes:

```text
https://yourdomain.com
```

to:

```text
127.0.0.1:8080
```

---

## SSL Automation

Installs:

```text
Certbot
```

Automatically generates:

```text
Let's Encrypt SSL certificates
```

No manual SSL setup required.

---

## Firewall Configuration

Automatically allows:

```text
22
80
443
```

Using:

```text
UFW
```

---

## Automatic Backup System

Creates:

```text
/opt/termix-backups
```

Automatic daily backups:

```text
03:00 AM
```

Backup script:

```text
/usr/local/bin/termix-backup.sh
```

Cron:

```text
/etc/cron.d/termix-backup
```

---

## Watchtower Auto Updates

Automatically deploys:

```text
Watchtower
```

Features:

- Container monitoring
- Automatic image updates
- Cleanup old images
- Background updates

---

## Hostragons Branding

Adds:

```text
/etc/update-motd.d/
```

Automatically displays:

```text
Powered by Hostragons Hosting
```

Runs:

```bash
bash <(curl -fsSL https://cdn.hostragons.com/storage/bash/hostragons_motd.sh)
```

after installation.

---

# 🖥 Supported Operating Systems

Compatible with:

- Ubuntu 20+
- Ubuntu 22+
- Debian
- VPS environments
- Dedicated servers
- KVM virtualization
- Cloud instances

---

# ☁ Supported Providers

Works with:

- AWS EC2
- AWS Lightsail
- Microsoft Azure
- Google Cloud
- Oracle Cloud
- DigitalOcean
- Vultr
- Hetzner
- Contabo
- OVH
- Linode
- Hostinger VPS
- Dedicated servers
- Self-hosted infrastructure

---

# 🔧 Requirements

Minimum:

- Root access
- Domain name
- Linux server
- Open ports:

```text
22
80
443
```

Recommended:

- 2 CPU
- 4GB RAM
- 20GB SSD

---

# 📂 Installed Components

Installed packages:

```text
curl
nginx
ufw
fail2ban
certbot
python3-certbot-nginx
docker.io
docker-compose-plugin
```

Containers:

```text
termix
guacd
watchtower
```

---

# 🖥 Example Installation

Run:

```bash
bash <(curl -fsSL https://cdn.hostragons.com/storage/bash/hostragons_termix_installer.sh)
```

Enter:

```text
Enter domain:
example.com

Enter email:
admin@example.com
```

Wait for automatic deployment.

Done:

```text
https://example.com
```

---

# 📈 Common Use Cases

- Self-hosted terminal server
- Remote desktop environments
- VPS management
- Linux administration
- Web-based SSH systems
- Cloud infrastructure management
- Hosting environments
- Development servers
- Team remote access
- Internal infrastructure tools

---

# 🏢 About Hostragons

Hostragons Global Limited

Company Number:

14320956

Headquarters:

London, United Kingdom

Address:

71–75 Shelton Street  
Covent Garden  
London WC2H 9JQ  
United Kingdom

Website:

https://www.hostragons.com/en/

Contact:

https://www.hostragons.com/en/contact

Client Area:

https://my.hostragons.com/

WhatsApp:

+44 7367 063425

Telegram:

https://t.me/hostragons

---

# ⚠ Disclaimer

Always deploy on clean systems whenever possible.

Recommended:

✔ Test first on staging environments

✔ Keep external backups

✔ Restrict SSH access

✔ Keep server updated

---

# 📜 License

MIT License

---

Made with ❤️ by Hostragons Global Limited
