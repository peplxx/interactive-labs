FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && yes | unminimize

RUN apt-get install -y sudo man-db vim nano curl wget iputils-ping fish asciinema \
    netcat-openbsd telnet file iproute2 net-tools tcpdump jq unzip tree \
    nodejs npm \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh \
    && curl -fsSL https://code-server.dev/install.sh | sh

WORKDIR /app

COPY package*.json .

RUN npm ci \
    && wget https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-x86_64-unknown-linux-musl.tar.gz \
    && tar -xvzf zellij-x86_64-unknown-linux-musl.tar.gz \
    && mv zellij /usr/local/bin/ \
    && rm zellij-x86_64-unknown-linux-musl.tar.gz

RUN usermod -aG sudo ubuntu \
    && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && chsh -s /usr/bin/fish ubuntu

USER ubuntu

EXPOSE 3000 8080

COPY . .

CMD ["/app/scripts/cmd.sh"]
