# Scripts

Directory of of helper scripts/configs serving different functionalities.

- `cmd.sh`: CMD script used by the containers (see Dockerfile and Dockerfile.vm)
- `entrypoint`: fish script launched by node.pty to start the lab terminal environment (see server.js)
- `forwarder.sh`: launched when terminal selection is to be copied to clipboard (see zellij.kdl)
- `init.sh`: VM builder script used only by packer to prepare boxes (see labenv.pkr.hcl)
- `record.fish`: Handles zellij session recording with asciinema (launched from entrypoint script)
- `zellij.kdl`: config file for zellij terminal workspace.
- `autologin.conf`: config file to enable autologin in sysbox container (drop-in override for `console-getty.service`)
- `startup.service`: systemd service to run `cmd.sh` on startup in sysbox container.
