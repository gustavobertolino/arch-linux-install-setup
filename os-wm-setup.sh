#Install i3 wm, fonts and other basic tools
sudo pacman -S xorg xorg-server xorg-xinit pulseaudio-alsa mesa mesa-libgl virtualbox-guest-utils dmenu ttf-dejavu i3 rxvt-unicode \
  brightnessctl
echo "exec i3" >> ~/.xinitrc

#Double-check locale and uncomment the en_US.UTF-8
LANG_USER=en_US.UTF-8^UTF-8;
sed -i "/^#$LANG_USER/ c$LANG_USER" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "setxkbmap -model abnt2 -layout br -variant abnt2" >> ~/.config/i3/config

touch .xResources
echo "URxvt.font: xft:DejavuSansMono:pixelsize=16" >> .Xresources
echo "URxvt.background: #000000" >> .Xresources
echo "URxvt.foreground: #ffffff" >> .Xresources

xrdb -load .Xresources
startx
