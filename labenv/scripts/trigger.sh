#!/bin/bash

set -e

docker run -d -p 5000:5000 --restart=always --name registry registry:2 2>/dev/null || true

IMAGES=$(docker compose -f docker-compose-vm.yaml config --images)

for img in $IMAGES; do
    docker pull -q "$img"
    docker tag "$img" "localhost:5000/$img"
    docker push "localhost:5000/$img" >/dev/null
done
