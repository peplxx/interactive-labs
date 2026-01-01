#!/bin/bash
set -e

# Disable interactive prompts
export DEBIAN_FRONTEND=noninteractive

# Update and install packages
sudo apt-get update
sudo apt-get install -y git man-db vim nano curl wget iputils-ping fish asciinema \
    netcat-openbsd telnet file iproute2 net-tools tcpdump jq unzip tree \
    nodejs npm docker.io docker-buildx

# For Docker usage without sudo 
sudo usermod -aG docker vagrant

# Install code-server and Zellij
curl -fsSL https://raw.githubusercontent.com/cdr/code-server/main/install.sh | sh
wget https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-x86_64-unknown-linux-musl.tar.gz
tar -xvzf zellij-x86_64-unknown-linux-musl.tar.gz
sudo mv zellij /usr/local/bin/
rm zellij-x86_64-unknown-linux-musl.tar.gz

# Create systemd service for labenv
cat <<EOF | sudo tee /etc/systemd/system/labenv.service
[Unit]
Description=Lab Environment
After=network.target

[Service]
Type=simple
User=vagrant
WorkingDirectory=/app/labenv
ExecStart=/usr/bin/npm run start
Restart=always
Environment=PASSWORD=code-server

[Install]
WantedBy=multi-user.target
EOF

# Set fish as default shell for vagrant
sudo chsh -s /usr/bin/fish vagrant

# Symlink /home/vagrant to /home/ubuntu
sudo ln -s /home/vagrant /home/ubuntu
