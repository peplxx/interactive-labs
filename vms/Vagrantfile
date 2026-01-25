Vagrant.configure("2") do |config|
  config.vm.box = "labenv"
  config.vm.box_version = "1.0.0"
  
  # Synced Folders
  config.vm.synced_folder ".", "/vagrant", disabled: true, type: "rsync"
  config.vm.synced_folder "./workspace.vm", "/home/ubuntu", create: true, type: "rsync"
  config.vm.synced_folder "./workshop", "/app/workshop", type: "rsync"

  # SSH and network config
  if ARGV[0] == "up" && ARGV.include?("--provider hyperv")
    config.ssh.username = "root"     # to sync /app/workshop
    config.ssh.password = "vagrant"
    config.vm.network "private_network", bridge: "Default Switch"
  else
    config.ssh.username = "ubuntu"
    config.ssh.password = "ubuntu"
    config.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", auto_correct: true
    config.vm.network "forwarded_port", guest: 3000, host: 3000, id: "app", auto_correct: true
    config.vm.network "forwarded_port", guest: 8080, host: 8080, id: "ide", auto_correct: true
    config.vm.network "forwarded_port", guest: 5800, host: 5800, id: "browser", auto_correct: true
  end

  # Virtualbox specific configuration
  config.vm.provider "virtualbox" do |vb|
    vb.name = "labenv"
    vb.memory = "4096"
    vb.cpus = 4
  end

  # Hyper-V specific configuration (comment out if not using hyperv)
  config.vm.provider "hyperv" do |hv|
    hv.cpus = 4
    hv.memory = 4096
  end

  # Libvirt specific configuration
  config.vm.provider "libvirt" do |lv|
    lv.cpus = 4
    lv.memory = 4096
  end

  # UTM specific configuration
  config.vm.provider "utm" do |utm|
    utm.name = "labenv"
    utm.memory = 4096
    utm.cpus   = 4
  end

  # Run provisioning script
  config.vm.provision "shell", path: "vms/provision.sh"
end
