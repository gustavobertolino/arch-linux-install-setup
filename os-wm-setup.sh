sudo pacman -S xorg xorg-server xorg-xinit pulseaudio-alsa mesa mesa-libgl virtualbox-guest-utils dmenu ttf-linux-libertine i3 rxvt-unicode 
echo "exec i3" >> ~/.xinitrc
startx
