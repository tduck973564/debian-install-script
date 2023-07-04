#!/bin/bash

# Fedora Install Script by tduck973564

echo "CD into home directory"
cd ~

echo "Enable contrib"

sudo sh -c "echo '# See https://wiki.debian.org/SourcesList for more information.
deb http://deb.debian.org/debian bookworm main non-free-firmware non-free contrib
deb-src http://deb.debian.org/debian bookworm main non-free-firmware non-free contrib

deb http://deb.debian.org/debian bookworm-updates main non-free-firmware non-free contrib
deb-src http://deb.debian.org/debian bookworm-updates main non-free-firmware non-free contrib

deb http://security.debian.org/debian-security/ bookworm-security main non-free-firmware non-free contrib
deb-src http://security.debian.org/debian-security/ bookworm-security main non-free-firmware non-free contrib

# Backports allow you to install newer versions of software made available for this release
deb http://deb.debian.org/debian bookworm-backports main non-free-firmware non-free contrib
deb-src http://deb.debian.org/debian bookworm-backports main non-free-firmware non-free contrib
' > /etc/apt/sources.list"
sudo apt update

echo "Install flatpak"
sudo apt install -y flatpak plasma-discover-backend-flatpak kde-config-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo apt remove firefox-esr
flatpak install -y org.mozilla.firefox

echo "Installation of GitHub CLI and setup of Git"
sudo apt install -y gh
sh -c "gh auth login"

echo "Type in your git username: "
read GITUSERNAME
echo "Type in your git email: "
read GITEMAIL

git config --global user.name $GITUSERNAME
git config --global user.email $GITEMAIL

echo "Installation of build-essential"
sudo apt install build-essential

echo "Installation of apps"
sudo apt remove -y ibus

sudo apt install -y \
pavucontrol \
openssl \
libdvd-pkg

sudo apt install -y libavcodec-extra \
  gstreamer1.0-libav              \
  gstreamer1.0-plugins-ugly       \
  gstreamer1.0-vaapi;

flatpak install -y flathub \
org.gimp.GIMP \
org.kde.kdenlive \
org.inkscape.Inkscape \
com.github.wwmm.easyeffects \
org.mozilla.firefox

echo "Download icon theme and fonts"
sudo apt install -y fonts-inter fonts-ibm-plex

echo "Install AppImageLauncher"
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:appimagelauncher-team/stable
sudo apt update
sudo apt install -y appimagelauncher

sudo apt autoremove -y
sudo apt update
echo -e '\nDone!'
