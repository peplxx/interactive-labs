# interactive-labs

Enhance your existing workshops with a practice environment.

![screenshot](./screenshot.png)

## Demo

1. Clone this repository
2. Run sample workshop with `docker compose up -d`
3. Access at <http://localhost:3000>

## Workshop Development in Docker

1. Create a directory of `*.md` files with workshop instructions (refer to the [example](./workshop)).

1. Update [docker-compose.yaml](./docker-compose.yaml) to bind-mount directories and add  apps as needed.

    ```yaml
    labenv:
        volumes:
            - ./workspace:/home/ubuntu
            - ./workshop:/app/workshop
            - /var/run/docker.sock:/var/run/docker.sock
    app1:
        ...
    app2:
        ...
    ```

1. Deploy the workshop. Changes to Markdown content are hot-reloaded.

    ```bash
    docker compose up -d
    ```

## Local Development

```bash
cd labenv
npm install
npm run dev
```

## Courses

Checkout some courses utilizing the platform:

- Fundamentals of Information Security: <https://github.com/Inno-CyberSec/FIS-F25>
- Network and Cyber Security: <https://github.com/Inno-CyberSec/NCS-F25>
- Secure System Development: <https://github.com/Inno-CyberSec/SSD-S26>
