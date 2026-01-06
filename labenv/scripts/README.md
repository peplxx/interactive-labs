# Scripts

Directory of of helper scripts serving different functionalities.

- `cmd.sh`: CMD script used by the containers (see Dockerfile and Dockerfile.vm)
- `entrypoint`: fish script launched by node.pty to start the lab terminal environment (see server.js)
- `forwarder.sh`: launched when terminal selection is to be copied to clipboard (see zellij.kdl)
- `init.sh`: VM builder script used only by packer to prepare boxes (see labenv.pkr.hcl)
- `record.fish`: Handles zellij session recording with asciinema (launched from entrypoint script)
- `zellij.kdl`: config file for zellij terminal workspace.
