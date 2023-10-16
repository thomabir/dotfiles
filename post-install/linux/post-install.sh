#!/bin/bash

# clone dotfiles (includes this file)
# sudo apt install git
# git clone https://github.com/thomabir/dotfiles.git
# copy contents to ~/.config

# XDG variables
echo "export XDG_CACHE_HOME=$HOME/.cache" >> ~/.profile
echo "export XDG_CONFIG_HOME=$HOME/.config" >> ~/.profile
echo "export XDG_DATA_HOME=$HOME/.local/share" >> ~/.profile
echo "export XDG_STATE_HOME=$HOME/.local/state" >> ~/.profile
. ~/.profile

# git
git config --global credential.helper store
git config --global user.name "thomabir"
git config --global user.email "thomabir@phys.ethz.ch"

# authenticate with git
cd ~/Downloads
git clone https://github.com/thomabir/roam.git
# enter username and password
rm -rf roam

# basics
sudo apt --assume-yes install build-essential cmake unzip
mkdir ~/code

# Iosevka font
cd ~/Downloads
wget https://github.com/be5invis/Iosevka/releases/download/v26.3.3/super-ttc-iosevka-26.3.3.zip
unzip super-ttc-iosevka-26.3.3.zip
mkdir -p ~/.fonts/truetype/iosevka
cp iosevka.ttc ~/.fonts/truetype/iosevka/
sudo fc-cache -f -v
rm iosevka.ttc
rm super-ttc-iosevka-26.3.3.zip

#
# Emacs 29.1
# Source: https://arnesonium.com/2023/07/emacs-29-1-on-ubuntu-22-04-lts
#

# prepare
sudo apt  --assume-yes install libxpm-dev libjpeg-dev libgif-dev libtiff-dev \
    libgnutls28-dev libgtk-3-dev libncurses-dev
sudo apt build-dep emacs
sudo apt --assume-yes install libgccjit0 libgccjit-10-dev libjansson4 libjansson-dev \
    gnutls-bin libtree-sitter-dev gcc-10 imagemagick libmagick++-dev \
    libwebp-dev webp libxft-dev libxft2
export CC=/usr/bin/gcc-10
export CXX=/usr/bin/gcc-10

# download
cd ~/Downloads
wget http://mirror.fcix.net/gnu/emacs/emacs-29.1.tar.xz
tar -xf emacs-29.1.tar.xz 
rm emacs-29.1.tar.xz

# build
cd emacs-29.1
./autogen.sh
./configure --with-native-compilation=aot --with-imagemagick --with-json \
    --with-tree-sitter --with-xft
make -j$(nproc)
sudo make install

# configure
# cd ~/.config
# rm emacs if exists
# git clone ...

# clean up
rm -r ~/Downloads/emacs-29.1/
