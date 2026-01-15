# https://github.com/alchemy-solutions/vagrant-cloud-images

Vagrant.configure("2") do |config|
  config.vm.box = "labenv"

  # Different VMMs may require different parameters here
  config.vm.network "private_network", type: "dhcp"

  # Trigger to prepare Docker images on the host before bringing up the VM
  config.trigger.before :up do |trigger|
    trigger.info = "Caching Docker images via local registry..."
    trigger.run = {path: "labenv/scripts/trigger.sh"}
  end

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

  # Hyper-V specific configuration
  config.vm.provider "hyperv" do |hv|
    hv.cpus = 4
    hv.memory = 4096
  end

  # Libvirt specific configuration
  config.vm.provider "libvirt" do |lv|
    lv.memory = 4096
    lv.cpus = 4
  end

  # UTM specific configuration
  config.vm.provider "utm" do |utm|
    utm.name = "labenv"
    utm.cpus   = 4
    utm.memory = 4096
  end

  # Copy docker-compose file to the VM
  config.vm.provision "file", source: "docker-compose-vm.yaml", destination: "/tmp/docker-compose.yaml"

  # Run provisioning script
  config.vm.provision "shell", path: "labenv/scripts/provision.sh"
end
