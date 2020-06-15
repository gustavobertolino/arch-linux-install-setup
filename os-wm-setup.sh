#Install i3 wm, fonts and other basic tools
sudo pacman -S xorg xorg-server xorg-xinit pulseaudio-alsa brightnessctl mesa mesa-libgl virtualbox-guest-utils i3 dmenu shutter \ 
  ttf-dejavu rxvt-unicode unzip \
  brightnessctl lightdm lightdm-gtk-greeter mlocate htop neofetch feh 

echo "Do you want also install developer setup packages? [y=1/N=0]"
read aws
if [$aws == 1]; then
  sudo pacman -S httpie git tig ranger diff-so-fancy clojure erlang elixir ruby ruby-irb rubygems \
  redis mysql postgresql rabbitmq docker docker-compose aws-cli emacs
  
  sudo pacman -S gcc python python-pip
  sudo pip install pgcli mycli
  
fi

#Run i3 wm
echo "exec i3" >> ~/.xinitrc

#Double-check locale and uncomment the en_US.UTF-8
LANG_USER=en_US.UTF-8^UTF-8;
sed -i "/^#$LANG_USER/ c$LANG_USER" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "exec setxkbmap -model abnt2 -layout br -variant abnt2" >> ~/.config/i3/config

#Set documents folder and desktop background
mkdir -p ~/documents
IMAGE_URL=https://i.pinimg.com/originals/e9/83/9c/e9839c0bf09bddcce7ac3ce0f2df047c.jpg
IMAGE_FILE=e9839c0bf09bddcce7ac3ce0f2df047c.jpg
wget -c $IMAGE_URL
mv IMAGE_FILE dark-wallpaper.jpg
mv dark-wallpaper ~/documents
echo "exec_always feh --bg-scale ~/documents/dark-wallpaper.jpg" >> ~.config/i3/config

#Set terminal font, background and transparency in terminal
touch .xResources
echo "URxvt.font: xft:DejavuSansMono:pixelsize=16" >> .Xresources
echo "URxvt.background: #000000" >> .Xresources
echo "URxvt.foreground: #ffffff" >> .Xresources
updatedb
xrdb -load .Xresources

#Enable display log-in screen (display manager)
sudo systemctl enable lightdm

echo "Run reboot command or Ctrl+C to cancel. After rebooting you will see new i3-wm layout: "
read aws
reboot
