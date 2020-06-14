#!/bin/bash

echo "Welcome to arch linux automating install script!"

# Set up network connection
read -p "Are you connected to internet? [y=1/N=0]: " neton
if ![ $neton = 1 ] ; then
  echo "Please! Connect to internet to continue..."
  exit
fi

#Checking internet connection
while true;
do
  ping -c1 google.com
  if [ $? -eq 0 ]
  then
    echo ""
    echo "internet connection OK!"
    break
  fi
done

# Filesystem mount warning
echo ""
echo "This script will create and format the partitions as follows:"
echo "/dev/sda1 - 512Mib will be mounted as /boot/efi"
echo "/dev/sda2 - 9GiB will be used as /"
echo "/dev/sda3 - 1G will be used as swap"
echo "/dev/sda4 - rest of space will be mounted as /home"

echo "Continue? [y=1/N=0]: "
read fsok
if ![ $fsok = 1 ]; then
  echo ""
  echo "Exiting! Edit the script and run it again to continue..."
  exit 0
fi

echo "Put the disk: (Ex. /dev/sda)"
read disk
sed -e "s/\s*\([\+0-9a-zA-Z]*\).*/\1/" << EOF | fdisk $disk
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk
  +512M # 512 MB boot parttion
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
  +9G
  n # new partition
  p # primary partition
  3 # partion number 3
    # default, start immediately after preceding partition
  +1G 
  n #new partition
  p # primary partition
  4 # partition number 4
    # default - start at beginning of disk
    # default - extend to the end of the disk
  a # make a partition bootable
  1 # bootable partition is partition 1 -- /dev/sda1
  p # print the in-memory partition table
  w # write the partition table
  t # change partition type to swap
  3 # partition to be swap
  82 # code for swap
  w # write the changes
  q # and we're done
EOF

# Format the partitions
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda4

mkswap /dev/sda3
swapon /dev/sda3

# Mount the partitions
mount /dev/sda2 /mnt

mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

mkdir -p /mnt/home
mount /dev/sda4 /mnt/home

#Double-check partitions and mounting
lsblk

echo "Continue? [y=1/N=0]: "
read aws
if ![$aws = 1]; then
  echo ""
  echo "Exiting install..."
  exit
fi

#Install arch linux packages
pacstrap /mnt base linux sudo vim wget grub efibootmgr networkmanager

#Generate fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

#Enter the installed OS
arch-chroot /mnt

#Download and run post-install script
wget -c https://raw.githubusercontent.com/gustavobertolino/arch-linux-install-setup/master/post-install.sh
sh post-install.sh
