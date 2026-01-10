# Scripts

Directory of of helper scripts/configs serving different functionalities.

## Container-related

- `cmd.sh`: CMD script used by the containers (see Dockerfile and Dockerfile.vm)
- `entrypoint`: fish script launched by node.pty to start the lab terminal environment (see server.js)
- `forwarder.sh`: launched when terminal selection is to be copied to clipboard (see zellij.kdl)
- `record.fish`: Handles zellij session recording with asciinema (launched from entrypoint script)

## VM-related

- `init.sh`: VM builder script used only by packer to prepare boxes (see labenv.pkr.hcl)
- `trigger.sh`: runs before `vagrant up` to pull required Docker images on the host and expose them via a local container registry for faster retrieval in VMs.
- `provision.sh`: provisioner script runs on VM startup

## Configs

- `zellij.kdl`: config file for zellij terminal workspace.
- `autologin.conf`: config file to enable autologin in sysbox container (drop-in override for `console-getty.service`)
- `startup.service`: systemd service to run `cmd.sh` on startup in sysbox container.
