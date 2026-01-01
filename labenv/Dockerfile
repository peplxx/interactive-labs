FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Unminimize the base image
RUN apt-get update && yes | unminimize

# Install essential packages
RUN apt-get install -y sudo man-db vim nano curl wget iputils-ping fish asciinema \
    netcat-openbsd telnet file iproute2 net-tools tcpdump jq unzip tree procps \
    nodejs npm \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Install docker cli, compose plugin, code-server, and zellij
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-29.1.3.tgz \
    && tar -xzf docker-29.1.3.tgz && mv ./docker/* /usr/local/bin \
    && mkdir -p /usr/local/lib/docker/cli-plugins \
    && wget https://github.com/docker/compose/releases/download/v5.0.1/docker-compose-linux-x86_64 \
    && chmod +x docker-compose-linux-x86_64 && mv docker-compose-linux-x86_64 /usr/local/lib/docker/cli-plugins/docker-compose \
    && curl -fsSL https://raw.githubusercontent.com/cdr/code-server/main/install.sh | sh \
    && wget https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-x86_64-unknown-linux-musl.tar.gz \
    && tar -xzf zellij-x86_64-unknown-linux-musl.tar.gz && mv zellij /usr/local/bin/

WORKDIR /app

COPY package*.json .

RUN npm ci \
    && usermod -aG sudo ubuntu \
    && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && chsh -s /usr/bin/fish ubuntu

USER ubuntu

EXPOSE 3000 8080

COPY . .

CMD ["/app/scripts/cmd.sh"]
