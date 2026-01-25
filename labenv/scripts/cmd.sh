#!/bin/bash

set -xe

sudo chown -R 1000:1000 /home/ubuntu

# sudo groupadd -g "$(stat -c '%g' /var/run/docker.sock)" docker || true
# sudo usermod -aG docker ubuntu

ln -sf /app/workshop /home/ubuntu/ || true

mkdir -p /home/ubuntu/.config/zellij
cp /app/scripts/zellij.kdl /home/ubuntu/.config/zellij/config.kdl

exec sudo -E -u ubuntu npm run start