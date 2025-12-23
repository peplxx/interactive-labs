# interactive-labs

Self-hosted interactive workshop environment. Enhance your existing workshops with a practice environment.

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
            - ./workshop:/app/slides
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
