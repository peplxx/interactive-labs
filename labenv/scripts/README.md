# Scripts Directory

Directory of of helper scripts/configs serving different functionalities.

## Scripts

- `cmd.sh`: prepares environment before executing `npm run start` (used in Dockerfiles and vms/provision.sh)
- `start.fish`: launched by `node.pty` to start the lab terminal (see `server.js`)
- `forwarder.sh`: launched when terminal selection is to be copied to clipboard (see `zellij.kdl`)

## Configs

- `zellij.kdl`: for customizing terminal looks and behavior (copied by `cmd.sh` to its expected location)
