#!/bin/bash

echo "Welcome to arch linux automating install script!"

#Set keboard layout
loadkeys br-abnt2

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

read -p 'Continue? [y/N]: ' fsok
if ! [ $fsok = 'y' ] && ! [ $fsok = 'Y' ]
  then
    echo ""
    echo "Exiting! Edit the script and run it again to continue..."
    exit 0
fi
