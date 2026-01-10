#!/bin/bash

set -e

# Get host IP address and configure Docker to use host registry
HOST_IP=$(ip route show | grep default | awk '{print $3}' | head -n 1)
echo '{"insecure-registries": ["'$HOST_IP':5000"]}' > /etc/docker/daemon.json
systemctl restart docker

# Pull and retag images from host registry
IMAGES=$(docker compose -f /tmp/docker-compose.yaml config --images)
for img in $IMAGES; do
    echo "Pulling $img from host registry..."
    docker pull -q $HOST_IP:5000/$img
    docker tag $HOST_IP:5000/$img $img
    docker rmi $HOST_IP:5000/$img
done

# Start services using docker-compose
mv /tmp/docker-compose.yaml /app/docker-compose.yaml
cd /app && docker compose up -d

# Setup code-server as a systemd service
sudo -E tee /lib/systemd/system/code-server.service <<EOF
[Unit]
Description=code-server

[Service]
Type=exec
User=vagrant
Restart=on-failure
ExecStart=/usr/bin/code-server --bind-addr=0.0.0.0:8080 --auth none --disable-telemetry --disable-update-check --disable-workspace-trust --disable-getting-started-override /home/vagrant

[Install]
WantedBy=multi-user.target
EOF

systemctl enable code-server
systemctl start code-server

# Display machine IP addresses
echo "Machine IP Addresses: " && hostname -I
