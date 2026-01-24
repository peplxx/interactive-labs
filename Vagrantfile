Vagrant.configure("2") do |config|
  config.vm.box = "labenv"
  config.vm.box_version = "1.0.0"
  
  # Optional trigger to run some logic on the host before 'vagrant up'
  # config.trigger.before :up do |trigger|
  #   trigger.run = {path: "vms/trigger.sh"}
  # end
  
  # Following lines are ignored when using Hyper-V, must use Machine IP instead of port-forwarding.
  # See: https://developer.hashicorp.com/vagrant/docs/providers/hyperv/limitations#limited-networking
  
  config.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", auto_correct: true
  config.vm.network "forwarded_port", guest: 3000, host: 3000, id: "app", auto_correct: true
  config.vm.network "forwarded_port", guest: 8080, host: 8080, id: "ide", auto_correct: true
  config.vm.network "forwarded_port", guest: 5800, host: 5800, id: "browser", auto_correct: true

  # Synced Folders
  config.vm.synced_folder ".", "/vagrant", disabled: true, type: "rsync"
  config.vm.synced_folder "./workspace.vm", "/home/ubuntu", create: true, type: "rsync"
  config.vm.synced_folder "./workshop", "/app/workshop", type: "rsync"

  # Initial SSH configuration
  config.ssh.guest_port = 22
  config.ssh.username = "root"
  config.ssh.password = "vagrant"
  config.ssh.forward_agent = false
  
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
    config.vm.network "private_network", bridge: "Default Switch"
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
