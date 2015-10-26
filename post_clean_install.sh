#!/bin/bash

# INFO:
# I have used this script to install my configurations after a clean Fedora 22 install.
# BUGS may be present. i.e. I do not assure that it will work.
# USAGE:
# Make post_clean_install.sh executable with 'chmod +x post_clean_install.sh'
# execute './post_clean_install.sh <YOURPASSWORD>' with a sudoer account.
# Enjoy

mkdir ~/opt
mkdir ~/bin
mkdir ~/src

echo $1 | sudo -S dnf update -y

echo $1 | sudo -S yum install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# GHC requirements
echo $1 | sudo -S dnf install glibc-devel ncurses-devel gmp-devel autoconf automake libtool gcc gcc-c++ make perl python ghc happy alex git -y
# To buil GHC doc
echo $1 | sudo -S dnf install docbook-utils docbook-utils-pdf docbook-style-xsl -y
# GHC suggestion: other packages that are useful for development: (optional)
echo $1 | sudo -S dnf install strace patch -y
# The next isn't so well done. See https://gist.github.com/yantonov/10083524
cd ~/src &&
git clone --recursive git://git.haskell.org/ghc.git &&
cd ghc &&
./boot &&
./configure --prefix=$HOME

echo $1 | sudo -S dnf install zsh -y
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sudo sh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
sudo chsh -s /bin/zsh hefesto

echo $1 | sudo -S dnf intall emacs -y

echo $1 | sudo -S su -c "cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF"

echo $1 | sudo -S dnf install google-chrome-stable -y

echo $1 | sudo -S dnf install alsa-lib.i686 fontconfig.i686 freetype.i686 glib2.i686 libSM.i686 libXScrnSaver.i686 libXi.i686 libXrandr.i686 libXrender.i686 libXv.i686 libstdc++.i686 pulseaudio-libs.i686 qt.i686 qt-x11.i686 zlib.i686 qtwebkit.i686

echo $1 | sudo -S dnf install alsa-lib.i686 fontconfig.i686 freetype.i686 \
glib2.i686 libSM.i686 libXScrnSaver.i686 libXi.i686 \
libXrandr.i686 libXrender.i686 libXv.i686 libstdc++.i686 \
	       pulseaudio-libs.i686 qt.i686 qt-x11.i686 zlib.i686 qtwebkit.i686

echo $1 | sudo -S dnf install http://dev.mysql.com/get/mysql-community-release-fc22-5.noarch.rpm

echo $1 | sudo -S dnf install vlc -y
echo $1 | sudo -S dnf install clementine -y
echo $1 | sudo -S dnf install git -y
echo $1 | sudo -S dnf install xmonad -y
echo $1 | sudo -S dnf install stalonetray -y
echo $1 | sudo -S dnf install xmobar -y
echo $1 | sudo -S dnf install feh -y
echo $1 | sudo -S dnf install maven -y
echo $1 | sudo -S dnf install xchat -y



cd ~/temp
wget --trust-server-names http://www.skype.com/go/getskype-linux-dynamic

mkdir ~/opt/skype
tar xvf skype-4.3* -C ~/opt/skype --strip-components=1

echo $1 | sudo -S ln -s ~/opt/skype/skype.desktop /usr/share/applications/skype.desktop
echo $1 | sudo -S ln -s ~/opt/skype/icons/SkypeBlue_48x48.png /usr/share/icons/skype.png
echo $1 | sudo -S ln -s ~/opt/skype/icons/SkypeBlue_48x48.png /usr/share/pixmaps/skype.png

touch ~/bin/skype
chmod 755 ~/bin/skype

cat << EOF > ~/bin/skype
#!/bin/sh
export SKYPE_HOME="~/opt/skype"
 
\$SKYPE_HOME/skype --resources=\$SKYPE_HOME \$*
EOF


cd ~
git clone https://github.com/hhefesto/dotfiles.git
cd dotfiles
cp -r emacs.d/ ~/.emacs.d
cp -r m2 ~/.m2
cp xmobarrc ~/.xmobarrc
cp -r xmonad ~/.xmonad
cp xsession ~/.xsession
cp zshrc ~/.zshrc




