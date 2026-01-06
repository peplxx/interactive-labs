#!/bin/bash

# CMD script used by the containers

set -xe

sudo chown -R 1000:1000 /home/ubuntu
mkdir -p /home/ubuntu/.config/zellij
cp /app/scripts/zellij.kdl /home/ubuntu/.config/zellij/config.kdl
cp /app/scripts/entrypoint /home/ubuntu/entrypoint

# If there is a template.markdown, copy it to the location where typora would catch it.
cp workshop/template.markdown /home/ubuntu/docs/README.md || true

# shellcheck source=/dev/null
source "/etc/os-release"

# Start server only if in debian-based container
if [ "$ID" = "debian" ]; then
    exec npm run start:server
else
  exec npm run start
fi
