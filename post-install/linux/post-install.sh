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
sudo apt --assume-yes install build-essential cmake unzip curl
mkdir ~/code

#
# Gnome desktop
#

# turn off mouse acceleration
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'

# Python with pyenv
# instructions: https://github.com/pyenv/pyenv#installation
sudo apt update; sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.profile
exec "$SHELL"
pyenv install 3.12
pyenv global 3.12
pip install numpy scipy matplotlib astropy pandas
pip install --upgrade pip

# Latex
sudo apt install texlive-full

# Iosevka font
cd ~/Downloads
wget https://github.com/be5invis/Iosevka/releases/download/v26.3.3/super-ttc-iosevka-26.3.3.zip
unzip super-ttc-iosevka-26.3.3.zip
mkdir -p ~/.fonts/truetype/iosevka
cp iosevka.ttc ~/.fonts/truetype/iosevka/
sudo fc-cache -f -v
rm ~/Downloads/iosevka.ttc
rm ~/Downloads/super-ttc-iosevka-26.3.3.zip

# Libertinus font
cd ~/Downloads
wget https://github.com/alerque/libertinus/releases/download/v7.040/Libertinus-7.040.zip
unzip Libertinus-7.040.zip
mkdir -p ~/.fonts/opentype/libertinus
cp -r Libertinus-7.040/static//OTF/*.otf ~/.fonts/opentype/libertinus/
sudo fc-cache -f -v
rm ~/Downloads/Libertinus-7.040.zip
rm -r ~/Downloads/Libertinus-7.040/

#
# Emacs 29.1
# Source: https://arnesonium.com/2023/07/emacs-29-1-on-ubuntu-22-04-lts
#

# prepare
sudo apt  -y install libxpm-dev libjpeg-dev libgif-dev libtiff-dev \
    libgnutls28-dev libgtk-3-dev libncurses-dev
sudo apt -y build-dep emacs
sudo apt -y install libgccjit0 libgccjit-11-dev libjansson4 libjansson-dev \
    gnutls-bin libtree-sitter-dev gcc-11 imagemagick libmagick++-dev \
    libwebp-dev webp libxft-dev libxft2
export CC=/usr/bin/gcc-11
export CXX=/usr/bin/gcc-11

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


# clean up
rm -rf ~/Downloads/emacs-29.1/

#
# SystemVerilog development tools
#

# Xilinx Vivado & Vitis
# see Xilinx website, login required

# verilator
# (don't use apt to install verilator, I get weird errors)
sudo apt -y install git help2man perl python3 make autoconf g++ flex bison ccache
sudo apt -y install libgoogle-perftools-dev numactl perl-doc mold
sudo apt -y install libfl2  # Ubuntu only (ignore if gives error)
sudo apt -y install libfl-dev  # Ubuntu only (ignore if gives error)
sudo apt -y install zlibc zlib1g zlib1g-dev  # Ubuntu only (ignore if gives error)
cd Downloads
git clone https://github.com/verilator/verilator
unset VERILATOR_ROOT
cd verilator
git checkout master
autoconf
./configure
make -j `nproc`  # if error, try just 'make'
sudo make install


# bazel (to build verible)
# instructions: https://bazel.build/install/ubuntu
sudo apt install apt-transport-https curl gnupg -y
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
sudo mv bazel-archive-keyring.gpg /usr/share/keyrings
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
sudo apt update && sudo apt -y install bazel

# Verible verilog tools
# instructions: https://github.com/chipsalliance/verible#developers-welcome
cd ~/Downloads
git clone https://github.com/chipsalliance/verible.git
cd verible
bazel build -c opt //...
bazel run -c opt :install -- -s /usr/local/bin
bazel test -c opt //...
rm -rf ~/Downloads/verible

# cocotb
pip install cocotb

