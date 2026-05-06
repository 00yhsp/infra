#!/bin/bash
# System Update
dnf update -y

# Install Docker
dnf install -y docker
systemctl enable docker
systemctl start docker

# Install Docker Compose (V2 is included in Amazon Linux 2023 via dnf)
# If not, download manually
if ! docker compose version &> /dev/null; then
  mkdir -p /usr/local/lib/docker/cli-plugins/
  curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
  chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
fi

# Permissions
usermod -aG docker ec2-user
