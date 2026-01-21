Vagrant.configure("2") do |config|
  config.vm.box = "labenv"
  config.vm.box_version = "1.0.0"

  # Different VMMs may require different parameters here
  config.vm.network "private_network", type: "dhcp"

  # Optional trigger to run some logic on the host before 'vagrant up'
  # config.trigger.before :up do |trigger|
  #   trigger.run = {path: "vms/trigger.sh"}
  # end

  # Initial SSH configuration
  config.ssh.username = "ubuntu"
  config.ssh.password = "ubuntu"
  
  # Synced folders
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./workspace.vm", "/home/ubuntu", create: true
  config.vm.synced_folder "./workshop", "/app/workshop", create: true
  
  # Virtualbox specific configuration
  config.vm.provider "virtualbox" do |vb|
    vb.name = "labenv-vm"
    vb.memory = "4096"
    vb.cpus = 4
    vb.gui = true
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

  # Run provisioning script
  config.vm.provision "shell", path: "vms/provision.sh"
end
