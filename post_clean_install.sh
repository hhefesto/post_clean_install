#!/bin/bash

# Copyright (c) 2017 https://github.com/hhefesto/post_clean_install, All rights reserved.

# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

# Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
# Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
# Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission. 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# INFO:
# He utilizado este script para mi personalización de mi ambiente justo después de haber instalado Centos 7
# BUGS: Seguro hay muchos.
# todo lo que sea "hhefesto" es mi nombre de usuario
# USAGE:
# ejecutar './post_clean_install.sh <YOURPASSWORD>' con un usuarios en Sudoer.
# Sonreir sí y sólo sí se pudo instalar sin error.

if [ "$#" -ne 1 ]; then
    echo "ERROR:"
    echo "Incorrect number of parameters."
    echo "USAGE:"
    echo "sudo_user ~/>post_clean_install.sh [sudo_user password]"
    exit
fi

echo "Haciendo folders FHS en ~"
cd ~
mkdir ~/opt
mkdir ~/bin
mkdir ~/src
mkdir ~/dev

echo "dnf update"
echo $1 | sudo -S dnf update -y

echo "Instalando repositorios rpmFusion para dnf"
echo $1 | sudo -S dnf install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

echo "Bajando paquetes rpm inexitentes en los repositorios de dnf."
wget -O dropbox.rpm dropbox.rpm https://www.dropbox.com/download?dl=packages/fedora/nautilus-dropbox-2015.10.28-1.fedora.x86_64.rpm

echo "Instalando."
echo $1 | sudo -S dnf install vim texlive scrot xclip calibre zsh emacs tomcat alsa-lib.i686 fontconfig.i686 freetype.i686 glib2.i686 libSM.i686 libXScrnSaver.i686 libXi.i686 libXrandr.i686 libXrender.i686 libXv.i686 libstdc++.i686 pulseaudio-libs.i686 qt.i686 qt-x11.i686 zlib.i686 qtwebkit.i686 vlc clementine git xmonad stalonetray xmobar feh maven xchat sshpass android-opengl-api.noarch gimp vagrant VirtualBox.x86_64 libpqxx-devel.x86_64 gparted octave readline-devel.x86_64 gmp.x86_64 freeglut-devel.x86_64 htop dropbox.rpm fvwm network-manager-applet xscreensaver nall nautilus-open-terminal levien-inconsolata-fonts.noarch -y

echo "Quitando paquetes rpm."
rm *rpm

echo "Desinstalando cosas..."
echo $1 | sudo -S dnf remove totem -y

# Node
## install nvm, a version manager of node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
npm install bower
npm install protractor

# zsh
echo "Instalando zsh y oh-my-zsh"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sudo sh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
echo $1 | sudo -S chsh -s /usr/bin/zsh $USER
chsh -s /usr/bin/zsh $USER

#echo "Instalando dependencias de GHC"
## GHC requirements
#echo $1 | sudo -S dnf install glibc-devel ncurses-devel gmp-devel autoconf automake libtool gcc gcc-c++ make perl python git -y
## To buil GHC doc
#echo $1 | sudo -S dnf install docbook-utils docbook-utils-pdf docbook-style-xsl -y
## GHC suggestion: other packages that are useful for development: (optional)
#echo $1 | sudo -S dnf install strace patch -y

#echo "Definiendo versiones/nombres de GHC, Cabal y Stack"
## https://gist.github.com/yantonov/10083524
#GHC_VERSION="7.10.2"  
#ARCHITECTURE="x86_64"  
## for 32 bit ARCHITECTURE="i386"      
#PLATFORM="unknown-linux"  
#GHC_DIST_FILENAME="ghc-$GHC_VERSION-$ARCHITECTURE-$PLATFORM-deb7.tar.bz2"

#CABAL_VERSION="1.22.4.0"
#CABAL_DIST_FILENAME="Cabal-$CABAL_VERSION.tar.gz"

#CABAL_INSTALL_VERSION="1.22.6.0"
#CABAL_INSTALL_DIST_FILENAME="cabal-install-$CABAL_INSTALL_VERSION.tar.gz"

#STACK_VERSION="0.1.6.0"  
#STACK_ARCHITECTURE="x86_64"  
#STACK_PLATFORM="linux"  
#STACK_DIST_FILENAME="stack-$STACK_VERSION-$STACK_PLATFORM-$STACK_ARCHITECTURE.tar.gz"

#echo "Descargando GHC tarball"
## get distr  
#cd $HOME/Downloads
#wget "https://www.haskell.org/ghc/dist/$GHC_VERSION/$GHC_DIST_FILENAME"  
#tar xvfj $GHC_DIST_FILENAME  
#cd ghc-$GHC_VERSION  

## install to  
#echo "Instalando GHC"
#./configure # --prefix=$HOME/Development/bin/ghc-$GHC_VERSION  

#make install

## Este paso es probable que no sea necesario dado que lo estamos instalando en /usr/local
## symbol links
#echo "Links simbólicos GHC"
#echo $1 | sudo -S cd /usr/local/bin &&
#echo $1 | sudo -S rm -f ghc &&
#echo $1 | sudo -S ln -s `pwd`/ghc-$GHC_VERSION ghc &&

## remove temporary files  
#cd $HOME/Downloads  
#rm -rfv ghc-$GHC_VERSION*

## The next isn't so well done. See https://gist.github.com/yantonov/10083524
#cd ~/src &&
#git clone --recursive git://git.haskell.org/ghc.git &&
#cd ghc &&
#./boot &&
#./configure --prefix=$HOME

# GIT configuration
echo "Configuring git."
git config --global user.email "daniel.herrera.rendon@gmail.com"
git config --global user.name "hhefesto"

# # # Chrome
# su -
# ## Then
# cat << EOF > /etc/dnf.repos.d/google-chrome.repo
# [google-chrome]
# name=google-chrome - \$basearch
# baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
# enabled=1
# gpgcheck=1
# gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
# EOF
# exit
# sudo dnf install google-chrome-stable -y

# Skype
# cd ~/temp
# wget --trust-server-names http://www.skype.com/go/getskype-linux-dynamic
# mkdir ~/opt/skype
# tar xvf skype-4.3* -C ~/opt/skype --strip-components=1
# echo $1 | sudo -S ln -s ~/opt/skype/skype.desktop /usr/share/applications/skype.desktop
# echo $1 | sudo -S ln -s ~/opt/skype/icons/SkypeBlue_48x48.png /usr/share/icons/skype.png
# echo $1 | sudo -S ln -s ~/opt/skype/icons/SkypeBlue_48x48.png /usr/share/pixmaps/skype.png
# touch ~/bin/skype
# chmod 755 ~/bin/skype
# cat << EOF > ~/bin/skype
# #!/bin/sh
# export SKYPE_HOME="~/opt/skype"
# \$SKYPE_HOME/skype --resources=\$SKYPE_HOME \$*
# EOF

echo "Importing my dot files."
cd ~/dev
git clone https://github.com/hhefesto/dotfiles.git
cd dotfiles
./makesymlinks.sh
