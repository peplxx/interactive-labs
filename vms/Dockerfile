# Dockerfile used by d2vm to create disk images for Vagrant boxes

# Main differences with original Dockerfile:
# - this is not intended to run as a container
# - full docker daemon is installed (not just CLI tools)
# - application is not bundled, will be downloaded during vagrant provisioning

FROM buildpack-deps:noble

ENV DEBIAN_FRONTEND=noninteractive

# Install system packages
RUN <<EOT
apt-get update && yes | unminimize

apt-get install -y sudo man-db vim nano file jq unzip tree procps htop curl wget \
    iputils-ping netcat-openbsd telnet iproute2 net-tools tcpdump traceroute lsof dnsutils \
    git lsb-release fish asciinema docker.io docker-buildx qemu-guest-agent openssh-server

apt-get clean -y && rm -rf /var/lib/apt/lists/* /var/cache/debconf/* /var/log/* /tmp/* /var/tmp/*
EOT

# Install user tools
ENV NODEJS_VERSION=24.13.0
ENV CODE_SERVER_VERSION=4.108.0
ENV DOCKER_COMPOSE_VERSION=v5.0.1
ENV ZELLIJ_VERSION=0.43.1

RUN <<-EOT
set -eux

wget -q "https://nodejs.org/dist/v$NODEJS_VERSION/node-v$NODEJS_VERSION-linux-x64.tar.xz"
wget -q "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-linux-x86_64"
wget -q "https://github.com/coder/code-server/releases/download/v$CODE_SERVER_VERSION/code-server-$CODE_SERVER_VERSION-linux-amd64.tar.gz"
wget -q "https://github.com/zellij-org/zellij/releases/download/v$ZELLIJ_VERSION/zellij-x86_64-unknown-linux-musl.tar.gz"

tar -xJf node-* -C /usr/local --strip-components=1 --no-same-owner
mkdir -p /usr/local/lib/docker/cli-plugins && chmod +x docker-compose-* && mv docker-compose-* /usr/local/lib/docker/cli-plugins/docker-compose
tar -xzf code-server-* -C /usr/local/lib && ln -s /usr/local/lib/code-server-*/bin/code-server /usr/local/bin/code-server
tar -C /usr/local/bin/ -xzf zellij-*

rm -rf *.tar.xz *.tar.gz *.tgz /tmp/*
EOT

# Prepare user account
RUN <<-EOT
echo "ubuntu:ubuntu" | chpasswd
usermod -aG sudo ubuntu
usermod -aG docker ubuntu
echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
chsh -s /usr/bin/fish ubuntu
EOT

# Setup autologin
RUN sed -i "s|ExecStart=.*|ExecStart=-/sbin/agetty --autologin ubuntu --keep-baud 115200,38400,9600 \%I \$TERM|" /usr/lib/systemd/system/serial-getty@.service
