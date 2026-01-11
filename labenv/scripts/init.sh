#!/bin/bash

# VM builder script used only by packer

set -xe

# Disable interactive prompts
export DEBIAN_FRONTEND=noninteractive

# Update and install packages
sudo apt-get update
sudo apt-get install -y git man-db vim nano curl wget iputils-ping fish asciinema \
    netcat-openbsd telnet file iproute2 net-tools tcpdump jq unzip tree docker.io docker-buildx

# For Docker usage without sudo 
sudo usermod -aG docker vagrant

# Install compose, code-server, and zellij
ARCH=$(uname -m)
case "$ARCH" in
    x86_64)
        ARCH="x86_64"
        ARCH_AKA="amd64"
        ;;
    aarch64|arm64)
        ARCH="aarch64"
        ARCH_AKA="arm64"
        ;;
esac

# Docker Compose installation
mkdir -p /usr/local/lib/docker/cli-plugins
wget "https://github.com/docker/compose/releases/download/v5.0.1/docker-compose-linux-${ARCH}"
chmod +x "docker-compose-linux-${ARCH}"
mv "docker-compose-linux-${ARCH}" /usr/local/lib/docker/cli-plugins/docker-compose

# Code Server installation
wget "https://github.com/coder/code-server/releases/download/v4.107.1/code-server_4.107.1_${ARCH_AKA}.deb"
sudo apt-get install -y "./code-server_4.107.1_${ARCH_AKA}.deb"
rm "code-server_4.107.1_${ARCH_AKA}.deb"

# Zellij installation
wget "https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-${ARCH}-unknown-linux-musl.tar.gz"
tar -xzf "zellij-${ARCH}-unknown-linux-musl.tar.gz"
mv zellij /usr/local/bin/
rm "zellij-${ARCH}-unknown-linux-musl.tar.gz"

# Set fish as default shell for vagrant
sudo chsh -s /usr/bin/fish vagrant

# Symlink /home/vagrant to /home/ubuntu (just in case)
sudo ln -s /home/vagrant /home/ubuntu
