#!/bin/bash

set -xe

sudo chown -R 1000:1000 /home/ubuntu

sudo groupadd -g "$(stat -c '%g' /var/run/docker.sock)" docker || true
sudo usermod -aG docker ubuntu

ln -sf /app/workshop /home/ubuntu/

mkdir -p /home/ubuntu/.config/zellij    
cp /app/scripts/zellij.kdl /home/ubuntu/.config/zellij/config.kdl

cp /app/scripts/start.fish /home/ubuntu/start.fish

exec npm run start
