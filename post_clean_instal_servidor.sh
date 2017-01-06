#!/bin/bash

# INFO:
# He utilizado este script para mi personalización de mi ambiente justo después de haber instalado Fedora Server 23 utilizando el usuario root
# BUGS: Seguro hay muchos.
# USAGE:
# Hacer post_clean_install.sh ejecutable con 'chmod +x post_clean_install_servidor.sh'
# ejecutar './post_clean_install.sh con root
# Sonreir sí y sólo sí se pudo instalar sin error.

echo "Haciendo folders FHS en ~"
mkdir ~/opt
mkdir ~/bin
mkdir ~/src
mkdir ~/dev

echo "dnf update"
dnf update -y

echo "instalando repositorios rpmFusion para dnf"
sudo yum install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

echo "Instalando cosas..."
sudo dnf install vim xclip zsh emacs nodejs alsa-lib.i686 fontconfig.i686 freetype.i686 glib2.i686 libSM.i686 libXScrnSaver.i686 libXi.i686 libXrandr.i686 libXrender.i686 libXv.i686 libstdc++.i686 pulseaudio-libs.i686 qt.i686 qt-x11.i686 zlib.i686 qtwebkit.i686 clementine git feh sshpass gimp libpqxx-devel.x86_64 gparted readline-devel.x86_64 gmp.x86_64 freeglut-devel.x86_64 -y

# zsh
echo "Instalando zsh y oh-my-zsh"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
sudo chsh -s /usr/bin/zsh root

# GIT configuration
echo "Configuring git."
git config --global user.email "daniel.herrera.rendon@gmail.com"
git config --global user.name "hhefesto"

# echo "Importing my dot files."
# cd ~/dev
# git clone https://github.com/hhefesto/dotfiles.git
# cd dotfiles
# ./makesymlinks.sh
