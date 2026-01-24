# Labenv VMs

Instructions to build VMs for the lab environment

1. Install [d2vm](https://github.com/linka-cloud/d2vm) with docker

    ```bash
    docker pull linkacloud/d2vm:latest
    alias d2vm="docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock --privileged -v \$PWD:/d2vm -w /d2vm linkacloud/d2vm:latest"
    ```

1. Create disk image from the provided `Dockerfile`

    ```bash
    cd vms
    docker build -t sh3b0/labenv:vm .
    d2vm convert --network-manager netplan -s 20G -p vagrant -o <box.qcow2|box.vmdk|box.vhdx> sh3b0/labenv:vm
    ```

1. Create Vagrant box for your provider

    - Libvirt

        ```bash
        cd libvirt
        mv ../box.qcow2 box.img
        tar -czvf package.box ./box.img ./Vagrantfile ./metadata.json
        ```

    - VirtualBox

        ```bash
        cd virtualbox
        mv ../box.vmdk .
        tar -czvf package.box ./box.vmdk ./box.ovf ./Vagrantfile ./metadata.json
        ```

    - Hyper-V

        ```bash
        cd hyperv
        mkdir -p "Virtual Hard Disks"
        mv ../box.vhdx ./"Virtual Hard Disks"
        tar -czvf package.box ./*
        ```

1. Import local boxes to Vagrant

    ```bash
    vagrant box add import.json
    ```

1. Run using the [Vagrantfile](../Vagrantfile) in project root

    ```bash
    vagrant up --provider <provider>
    ```
