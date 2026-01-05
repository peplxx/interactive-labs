Vagrant.configure("2") do |config|
  config.vm.box = "sh3b0/labenv"
  config.vm.box_version = "1.0.0"

  # Attach VM to the host network (bridged)
  config.vm.network "public_network"

  # Disable automatic SSH key insertion to use the default Vagrant key
  config.ssh.insert_key = false
  
  # Synced folders
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./workspace", "/home/vagrant/", create: true
  config.vm.synced_folder "./labenv", "/app", create: true
  config.vm.synced_folder "./workshop", "/app/labenv/workshop"

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

  # Provisioning script
  config.vm.provision "shell", inline: <<-SHELL
  sudo chown -R vagrant:vagrant /app/labenv
  sudo systemctl start labenv
  sudo systemctl enable labenv
  
  mkdir -p /home/vagrant/.config/zellij
  cp /app/scripts/zellij.kdl /home/vagrant/.config/zellij/config.kdl

  echo "Machine IP Addresses: "
  hostname -I

  SHELL
end
