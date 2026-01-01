#!/bin/bash

set -e

sudo chown -R 1000:1000 /home/ubuntu
mkdir -p /home/ubuntu/.config/zellij
cp /app/scripts/zellij.kdl /home/ubuntu/.config/zellij/config.kdl
cp /app/scripts/entrypoint /home/ubuntu/entrypoint
exec npm run start
