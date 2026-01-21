#!/bin/bash

set -e

# Fix /etc/hosts to ensure localhost resolves correctly
echo "127.0.0.1  localhost.localdomain  localhost" | sudo tee /etc/hosts

# Download stable labenv from github releases and run it
wget -q https://github.com/sh3b0/interactive-labs/releases/download/boxes/labenv-stable.zip
unzip labenv-stable.zip -d /app && rm labenv-stable.zip
cd /app && npm ci && npm run build && /app/scripts/cmd.sh

# Display machine IP addresses
echo "Access labenv on port 3000. Machine IPs: $(hostname -I)"
