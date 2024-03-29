#!/bin/sh

#	Automated script to install and setup
#	zsh
sudo apt install -y zsh tree
sudo chsh -s $(which zsh)
chsh -s $(which zsh)
sudo apt install -y git wget stow curl cmake
sudo apt install -y neovim vim  pip
sudo apt install -y taskwarrior fonts-powerline powerline 
sudo -H pip install virtualenvwrapper
sudo apt install -y python3-dev python-dev libxml2-dev libxslt-dev  # these are needed for YCM to work with other langaguges
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
sudo apt-get update
sudo pip install cdiff # side by side diff 
sudo apt install -y mono-complete nodejs npm cargo golang-go
npm install xbuild 
#git clone https://github.com/bryoh/dotfiles.git ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
curl -L git.io/antigen > antigen.zsh
cd ~/dotfiles
rm -rf ~/.zshrc # zsh will create an .zshrc file by default but we do not want it we want our own
stow zsh vim 
cd ~
vim +PluginInstall +qall # install vim plugins
#	i3
#cd ~
#sudo apt install -y i3 rofi
#sudo apt install -y xclip xsel 
#sudo apt install -y compton arandr lxappearance
#sudo apt install -y pavucontrol feh playerctl
#sudo apt install -y pactl xbacklight 
#sudo apt install -y scrot screenfetch
#sudo apt install -y apt-transport-https # makes sure apt is set up to work with https
## 	i3gaps
#sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake
#git clone https://www.github.com/Airblader/i3 ${HOME}/i3-gaps 
#cd ${HOME}/i3-gaps
#autoreconf --force --install
#rm -rf build
#mkdir -p build && cd build
#../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
#make
#sudo make install 
#cd ~
#sudo add-apt-repository ppa:system76/pop
#sudo add-apt-repository ppa:papirus/papirus
#sudo apt-get update 
#sudo apt install -y arc-theme pop-theme papirus-icon-theme
#	oh-my-zsh
#	vim + plugins
#	fonts
# Install polybar and its dependencies 
sudo apt install -y xcb-proto xcb-util-image xcb-util-wm xcb-util-xrm libxcb-ewmh-dev python-xcbgen

wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu yakkety-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
sudo apt-get update
sudo apt-get install -y polybar

#install sublime-text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update 
sudo apt install -y sublime-text

# Install ranger 
sudo apt install -y highlight atool w3m poppler-utils caca-utils
sudo apt install -y ranger 

cd ~
# install docker 
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo groupadd docker
sudo usermod -aG docker ${USER}
sudo apt install python3-pip
sudo apt update
sudo apt upgrade
pip3 install docker-compose


# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
