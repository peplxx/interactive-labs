packer {
  required_plugins {
    vagrant = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vagrant"
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

source "vagrant" "labenv-libvirt" {
  communicator = "ssh"
  source_path  = "cloud-image/ubuntu-24.04"
  box_version  = "20251213.0.0"
  provider     = "libvirt"
  output_dir   = "output/libvirt"
  skip_add     = true
  box_name     = "labenv"
}

build {
  sources = [
    "source.vagrant.labenv-virtualbox",
    # "source.vagrant.labenv-libvirt",
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
}
