#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== Starting Jellyfin Installation & Deployment ==="

# 1. Update system and install prerequisites
echo "-> Updating system and installing prerequisites..."
apt update && apt install -y ca-certificates curl gnupg

# 2. Add Docker's official GPG key and APT repository for Debian
echo "-> Setting up Docker repository..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# 3. Install Docker Engine and Docker Compose plugin
echo "-> Installing Docker Engine and Docker Compose..."
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 4. Ensure external Docker volumes exist
echo "-> Verifying external volumes..."
docker volume inspect jellyfin_jellyfin-config >/dev/null 2>&1 || \
  (echo "-> Creating named volume: jellyfin_jellyfin-config" && docker volume create jellyfin_jellyfin-config)

docker volume inspect jellyfin_jellyfin-cache >/dev/null 2>&1 || \
  (echo "-> Creating named volume: jellyfin_jellyfin-cache" && docker volume create jellyfin_jellyfin-cache)

# 5. Launch Jellyfin stack
echo "-> Starting Jellyfin container..."
docker compose up -d

echo "=== Installation Complete! ==="
echo "Jellyfin is running at: http://$(hostname -I | awk '{print $1}'):8096"
