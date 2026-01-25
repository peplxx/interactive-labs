packer {
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = "~> 1"
    }
  }
}

variable "vhdx_path" {
  type        = string
  description = "Path to the VHDX file"
}

variable "vhdx_checksum" {
  type        = string
  description = "Checksum of the VHDX file"
}

source "hyperv-iso" "labenv" {
  vm_name          = "labenv"
  iso_url          = var.vhdx_path
  iso_checksum     = var.vhdx_checksum
  temp_path        = "C:/Windows/Temp"
  ssh_username     = "ubuntu"
  ssh_password     = "ubuntu"
  shutdown_command = "echo 'ubuntu' | sudo -S shutdown -P now"
  switch_name      = "Default Switch"
}

build {
  sources = [
    "source.hyperv-iso.labenv",
  ]

  post-processor "vagrant" {}
}
