packer {
  required_plugins {
    vagrant = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vagrant"
    }
    utm = {
      version = ">= v0.0.2"
      source  = "github.com/naveenrajm7/utm"
    }
  }
}

source "vagrant" "labenv-virtualbox" {
  communicator = "ssh"
  source_path  = "cloud-image/ubuntu-24.04"
  box_version  = "20251213.0.0"
  provider     = "virtualbox"
  output_dir   = "output/virtualbox"
  skip_add     = true
  box_name     = "labenv"
}

source "vagrant" "labenv-hyperv" {
  communicator = "ssh"
  source_path  = "sture/ubuntu2404"
  box_version  = "2026.01.07.12"
  provider     = "hyperv"
  output_dir   = "output/hyperv"
  skip_add     = true
  box_name     = "labenv"
  template     = "./hyperv.gotmpl" 
}

source "vagrant" "labenv-libvirt" {
  communicator = "ssh"
  source_path  = "cloud-image/ubuntu-24.04"
  box_version  = "20251213.0.0"
  provider     = "libvirt"
  output_dir   = "output/libvirt"
  skip_add     = true
  box_name     = "labenv"
}

source "utm-utm" "labenv-utm" {
  communicator = "ssh"
  source_path = "/path/to/box.utm" # Replace with path to UTM box (typically under ~/.vagrant.d/boxes)
  output_directory = "output/utm"
  vm_name = "labenv"
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  shutdown_command = "echo 'vagrant' | sudo -S shutdown -P now"
}

build {
  sources = [
    "source.vagrant.labenv-virtualbox",
    # "source.vagrant.labenv-hyperv",
    # "source.vagrant.labenv-libvirt",
    # "source.utm-utm.labenv-utm",
  ]
  
  provisioner "shell" {
    script          = "scripts/init.sh"
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
  }

  # Uncomment the following block to enable Vagrant Cloud upload (set HCP_CLIENT_ID and HCP_CLIENT_SECRET first)
  # post-processor "vagrant-registry" {
  #   box_tag             = "sh3b0/labenv"
  #   version             = "1.0.0"
  #   version_description = "Lab Environment with support for virtualbox/libvirt"
  #   architecture        = "amd64"
  # }

  # Post-processor to create UTM box (uncomment if needed)
  # post-processor "utm-vagrant" {
  #   compression_level = 9
  #   output            = "output/utm.box"
  # }
}
