Vagrant.configure("2") do |config|
  config.vm.box = "sh3b0/labenv"
  config.vm.box_version = "1.0.0"

  # Attach VM to the host network (bridged)
  config.vm.network "public_network"

  # Disable automatic SSH key insertion to use the default Vagrant key
  config.ssh.insert_key = false
  
  # Synced folders
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./workspace.vm", "/home/vagrant", create: true
  config.vm.synced_folder "./workshop", "/app/workshop", create: true

  # Virtualbox specific configuration
  config.vm.provider "virtualbox" do |vb|
    vb.name = "labenv-vm"
    vb.memory = "4096"
    vb.cpus = 4
  end

  # Libvirt specific configuration
  config.vm.provider "libvirt" do |lv|
    lv.name = "labenv-vm"
    lv.memory = 4096
    lv.cpus = 4
  end

  # Copy docker-compose file to the VM
  config.vm.provision "file", source: "docker-compose-vm.yaml", destination: "/tmp/docker-compose.yaml"

  # Run provisioning script
  config.vm.provision "shell", inline: <<-SHELL
    cp /tmp/docker-compose.yaml /app/docker-compose.yaml
    cd /app && docker compose pull && docker compose up -d
    PASSWORD=code-server bash -c 'code-server --bind-addr 0.0.0.0:8080 ~' &
    echo "Machine IP Addresses: " && hostname -I
  SHELL
end
