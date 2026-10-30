# Homelab Jellyfin

An automated deployment setup for self-hosting **Jellyfin** via Docker Compose inside a Proxmox LXC or a fresh Linux machine.

Prerequisites:
- A fresh Linux environment (Debian 12 / Ubuntu recommended).
- Root or sudo privileges to install system packages and Docker.

---

Step:

1. Clone the Repository
Download the project repository and setup files from GitHub:
```bash
git clone https://github.com/harithdarwish/Homelab_Jellyfin.git
```

2) Create your custom .env file for secrets and configuration.
```bash
cd ~/Homelab_Jellyfin
```

4) Make the script executable. Install Docker & Docker Compose.
 ```bash
 chmod +x install-Jellyfin.sh && ./install-Jellyfin.sh
```

6) Run without sudo
 ```bash
 newgrp docker
```

7) Pull the required container images and start the UptimeKuma stack in the background.
```bash
docker compose up -d
```

8) Verify that all service containers
```bash
docker compose ps
```

9) Access the web.
      hostname -I
      http://<HOST_IP>:8096
