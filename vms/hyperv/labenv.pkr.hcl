packer {
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = "~> 1"
    }
  }
}

source "hyperv-iso" "labenv" {
  vm_name = "labenv"
  
  # Change values for your box
  iso_url = "file://D:/Boxes/box.vhdx"
  iso_checksum = "md5:1a050f073aef92c0a49b568b1bc71149"
  
  temp_path = "C:/Windows/Temp"
  ssh_username =  "ubuntu"
  ssh_password = "ubuntu"
  shutdown_command = "echo 'ubuntu' | sudo -S shutdown -P now"
  switch_name = "Default Switch" 
}

build {
  sources = [
    "source.hyperv-iso.labenv",
  ]
  
  post-processor "vagrant" { }
}
