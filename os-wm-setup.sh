#Install i3 wm, fonts and other basic tools
sudo pacman -S xorg xorg-server xorg-xinit pulseaudio-alsa brightnessctl mesa mesa-libgl virtualbox-guest-utils dmenu ttf-dejavu i3 rxvt-unicode \
  brightnessctl lightdm lightdm-gtk-greeter mlocate httpie htop ranger diff-so-fancy clojure erlang elixir ruby ruby-irb rubygems \
  redis postgresql rabbitmq docker docker-compose emacs

sudo pacman -S python python-pip
sudo pacman -S pip pgcli
echo "exec i3" >> ~/.xinitrc

#Double-check locale and uncomment the en_US.UTF-8
LANG_USER=en_US.UTF-8^UTF-8;
sed -i "/^#$LANG_USER/ c$LANG_USER" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "exec setxkbmap -model abnt2 -layout br -variant abnt2" >> ~/.config/i3/config

touch .xResources
echo "URxvt.font: xft:DejavuSansMono:pixelsize=16" >> .Xresources
echo "URxvt.background: #000000" >> .Xresources
echo "URxvt.foreground: #ffffff" >> .Xresources
updatedb

sudo systemctl enable lightdm

xrdb -load .Xresources
startx
