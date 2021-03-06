#!/bin/bash

# INFO:
# He utilizado este script para mi personalización de mi ambiente justo después de haber instalado Ubuntu 16 LTS
# BUGS: Seguro hay muchos.
# USAGE:
# Hacer post_clean_install.sh ejecutable con 'chmod +x post_clean_install.sh'
# ejecutar './post_clean_install.sh <YOURPASSWORD>' con un usuarios en Sudoer.
# Sonreir sí y sólo sí se pudo instalar sin error.

echo "Haciendo folders FHS en ~"
mkdir ~/opt
mkdir ~/bin
mkdir ~/src
mkdir ~/dev

echo "dnf update"
sudo apt-get update -y

echo "Instalando cosas..."
sudo apt-get install vim texlive scrot xclip calibre zsh emacs vlc clementine git xmonad stalonetray xmobar feh maven sshpass gimp vagrant gparted octave -y
# faltan xchat, virtualbox

# Node
## install nvm, a version manager of node
echo "Instalando cosas de Node"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
restart # no sé si esto haga lo que quiero que haga... el punto es que debe reabrir bash para que nvm se "vea"
nvm install node
npm install -g bower
npm install -g protractor
npm install -g angular-cli@latest

# PHP
sudo apt-get install composer
sudo apt-get install php-mbstring
sudo apt-get install php-xml

# zsh
echo "Instalando zsh y oh-my-zsh"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sudo sh #creo que esta no debe-ser/es necesaria
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
chsh -s /usr/bin/zsh hefesto

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
# cat << EOF > /etc/yum.repos.d/google-chrome.repo
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
