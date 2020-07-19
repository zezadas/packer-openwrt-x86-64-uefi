Inspired on mcandre/packer-templatesi and archlinux/arch-boxes this is a packer recipe to build x86-64 openwrt running on KVM with UEFI. This packer can be then provisioned with the following vagrant recipe: zezadas/vagrant-openwrt-x86-64-uefi .
This project use arch live boot ISO as support to flash openwrt image on disk.
This is intended to be used with qemu provisioner, but virtualbox is working too.

How to:
 - PACKER_LOG=1 packer build -force -only qemu vagrant.json
 - vagrant box add -f --name openwrt --provider libvirt openwrt.box


TODO:
 - have better README

