#Set local time
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

#Sync time with system clock time
hwclock --systohc

#Edit locale and uncomment the en_US.UTF-8
LANG_USER=en_US.UTF-8 UTF-8;
sed -i "/^#$LANG_USER/ c$LANG_USER" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" /etc/locale.conf

#Set keyboard layout for installed OS
echo "KEYMAP=br-abnt2" /etc/vconsole.conf

#Set hostname
read -p "Give a hostname: " hostname
echo $hostname /etc/hostnames
echo "127.0.1.1	$hostname.localdomain $hostname"
USER=$hostname

#Enable networkmanager
systemctl enable NetworkManager

#Add root password
echo "Add root password: "
passwd

#Install bootloader
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg

# Create new user
useradd -m -G wheel,power,storage,uucp,network $USER
sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers

# Set user password
echo "Set user password:"
passwd $USER

echo "The only thing left is to reboot into the new system."
echo "Press any key to reboot or Ctrl+C to cancel..."
read tmpvar
reboot
