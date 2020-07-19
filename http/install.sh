#!/bin/bash

set -e
set -x

if [ -e /dev/vda ]; then
  device=/dev/vda
elif [ -e /dev/sda ]; then
  device=/dev/sda
else
  echo "ERROR: There is no disk available for installation" >&2
  exit 1
fi
export device

URL_OPENWRT="https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-x86-64-generic-ext4-combined-efi.img.gz"
curl $URL_OPENWRT -o /tmp/openwrt-x86-64-generic-ext4-combined-efi.img.gz
curl https://downloads.openwrt.org/snapshots/targets/x86/64/sha256sums -o /tmp/checksum
sha256sum /tmp/openwrt-x86-64-generic-ext4-combined-efi.img.gz | grep `cat /tmp/checksum | grep openwrt-x86-64-generic-ext4-combined-efi.img.gz | cut -d ' ' -f1` && gunzip /tmp/openwrt-x86-64-generic-ext4-combined-efi.img.gz || true
dd if=/tmp/openwrt-x86-64-generic-ext4-combined-efi.img of="${device}"
sleep 2
sync
sleep 2
echo w | fdisk "${device}" || true
sleep 2
parted "${device}" resizepart 2 100%
resize2fs "${device}2" 
mount "${device}1" /mnt
echo "fs0:\\efi\\boot\\bootx64.efi" > "/mnt/startup.nsh" 
umount "${device}1"
efibootmgr -c -d "${device}" -p 1 -L "openwrt" -l '\efi\boot\bootx64.efi'
#mount /dev/sda2 /mnt
#mv shutdown /mnt/tmp
#mv p1 /mnt/tmp
#mv p2 /mnt/tmp

#chroot /mnt /bin/ash

#rm /mnt/tmp/shutdown
#rm /mnt/tmp/p1
#rm /mnt/tmp/p2
