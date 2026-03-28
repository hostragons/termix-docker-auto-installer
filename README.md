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
