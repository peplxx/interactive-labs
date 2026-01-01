# interactive-labs

Complement your IT training workshops with a practice environment.

![screenshot](./screenshot.png)

## Quick Start

1. Clone this repository
2. Run sample workshop with `docker compose up -d` or `vagrant up` (supports virtualbox/libvirt)
    - Update [docker-compose.yaml](./docker-compose.yaml) or [Vagrantfile](./Vagrantfile) to customize the environemnt as needed
3. Access at <http://localhost:3000>

## Building Locally

- Container option

```bash
cd labenv
docker build -t labenv .
docker run -d -p3000:3000 labenv
```

- Virtual Machine option

```bash
cd labenv
packer init .

# Adjust the commands to build for virtualbox/libvirt on amd64/arm64
vagrant box add cloud-image/ubuntu-24.04 -a amd64 --box-version 20251213.0.0 --provider virtualbox
packer build labenv.pkr.hcl
vagrant box add --name labenv output/virtualbox/package.box

# Test locally
vagrant init labenv
vagrant up
```

## Local Development

```bash
cd labenv
npm install
npm run dev
```

## Courses

Check out some courses utilizing the platform:

- Fundamentals of Information Security: <https://github.com/Inno-CyberSec/FIS-F25>
- Network and Cyber Security: <https://github.com/Inno-CyberSec/NCS-F25>
- Secure System Development: <https://github.com/Inno-CyberSec/SSD-S26>
