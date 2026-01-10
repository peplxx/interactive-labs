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
mkdir -p /usr/local/lib/docker/cli-plugins
wget https://github.com/docker/compose/releases/download/v5.0.1/docker-compose-linux-x86_64
chmod +x docker-compose-linux-x86_64 && mv docker-compose-linux-x86_64 /usr/local/lib/docker/cli-plugins/docker-compose
curl -fsSL https://raw.githubusercontent.com/cdr/code-server/main/install.sh | sh
wget https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-x86_64-unknown-linux-musl.tar.gz
tar -xzf zellij-x86_64-unknown-linux-musl.tar.gz && mv zellij /usr/local/bin/

# Set fish as default shell for vagrant
sudo chsh -s /usr/bin/fish vagrant

# Symlink /home/vagrant to /home/ubuntu (just in case)
sudo ln -s /home/vagrant /home/ubuntu
