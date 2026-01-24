#!/bin/bash

set -e

# Fix /etc/hosts to ensure localhost resolves correctly
echo "127.0.0.1  localhost.localdomain  localhost" | sudo tee /etc/hosts

echo "Download stable labenv from github releases..."
wget -q https://github.com/sh3b0/interactive-labs/releases/download/boxes/labenv-stable.zip
unzip -q labenv-stable.zip -d /app && rm labenv-stable.zip

echo "Installing npm dependencies and building the app..."
cd /app && npm ci && npm run build
cd /app && bash -c '/app/scripts/cmd.sh' &

echo "Access labenv on http://localhost:3000. Additional machine IPs: $(hostname -I)"
