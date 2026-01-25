# Labenv VMs

Instructions to build and run VMs for the lab environment.

## Run Preconfigured VM Images

1. Setup the recommended Virtual Machine Manager (VMM) for your platform

    - Windows: [Hyper-V Manager](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/get-started/install-hyper-v)
    - Linux: [QEMU/KVM + libvirt + virt-manager](https://christitus.com/vm-setup-in-linux/)
    - MacOS: [Lima](https://lima-vm.io/docs/installation/)
    - Hosted (Type-2) Hypervisor: [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

1. Download the corrsponding VM image from our [Release](https://github.com/Sh3b0/interactive-labs/releases/tag/boxes) page.

### Vagrant Boxes (VirtualBox, Libvirt, Hyper-V)

1. Use [import.json](./vms/import.json) to import downloaded boxes to vagrant.

    ```bash
    vagrant plugin install vagrant-libvirt # only needed for libvirt
    vagrant box add import.json
    ```

1. Run the enivonment and access at `http://<VM-IP>:3000`

    ```bash
    vagrant up --provider <hyperv|libvirt|virtualbox>
    ```

### Lima VMs

1. Download the `libvirt` box from [Release](https://github.com/Sh3b0/interactive-labs/releases/tag/boxes) page.

1. Extract to obtain `box.img` (i.e., the `.qcow2` disk image needed by lima)

    ```bash
    tar -xzvf labenv-libvirt-*.box
    ```

1. Copy necessary files to `~/.lima` (to be mounted in the VM)

    ```bash
    cp -r ../workshop ~/.lima
    cp provision.sh ~/.lima
    ```

1. Configure [`labenv.yaml`](./labenv.yaml) as needed

    ```bash
    limactl start ./labenv.yaml
    ```

## Build Your Own Image

1. Install [d2vm](https://github.com/linka-cloud/d2vm/releases/) for your platform.

1. Build docker image for `labenv:vm-amd64` and/or `labenv:vm-arm64`.

    ```bash
    docker buildx create --name mybuilder --use
    
    docker buildx build --platform linux/amd64 -t labenv:vm-amd64 --load .
    
    docker buildx build --platform linux/arm64 -t labenv:vm-arm64 --load .
    ```

1. Create `disk.raw` from the docker image with d2vm. See `d2vm convert --help` for details.

    ```bash
    d2vm convert \
        --platform linux/amd64 \
        --bootloader grub \
        --network-manager netplan \
        --size 20G \
        --password vagrant \
        --output disk-amd64.raw \
        labenv:vm-amd64

    d2vm convert \
        --platform linux/amd64 \
        --bootloader grub-efi \
        --network-manager netplan \
        --size 20G \
        --password vagrant \
        --output disk-arm64.raw \
        labenv:vm-arm64
    ```

1. Build final VM image for the target provider.

    - Hyper-V (amd64 only)

        ```bash
        cd hyperv
        qemu-img convert -O vhdx ../disk-amd64.raw "Virtual Hard Disks\labenv.vhdx"
        tar czfv labenv-hyperv-amd64.box ./*
        ```

    - VirtualBox (amd64 only)

        ```bash
        cd virtualbox
        qemu-img convert -O vmdk ../disk-amd64.raw box.vmdk
        tar czfv labenv-virtualbox-amd64.box ./*
        ```

    - libvirt (amd64 and arm64)

        ```bash
        cd libvirt
        qemu-img convert -O qcow2 ../disk-amd64.raw box.img
        tar czfv labenv-libvirt-amd64.box ./*
        ```

        ```bash
        cd libvirt
        qemu-img convert -O qcow2 ../disk-arm64.raw box.img
        tar czfv labenv-libvirt-arm64.box ./*
        ```

    - Lima (amd64 and arm64)

        - Lima only requires the `.qcow2` disk (already packaged within libvirt boxes)
        - For convenience, one could just reuse `libvirt/box.img`
