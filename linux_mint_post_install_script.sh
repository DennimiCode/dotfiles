#!/bin/bash

USER_NAME=$(whoami)
IS_PC=false
PC_ARCH=$(dpkg --print-architecture)
UBUNTU_CODENAME=$(source /etc/os-release && echo $UBUNTU_CODENAME)
UBUNTU_VERSION="24.04"
UBUNTU_DISTRO_NAME="ubuntu"
NODE_MAJOR=20

# Setup this PC as gaming or not
read -p "Is it PC (PC/Laptop for games)? (Y/N): " PC_CONFIRM
if [[ $PC_CONFIRM == [yY] || $PC_CONFIRM == [yY][eE][sS] ]]; then
  IS_PC=true
else
  IS_PC=false
fi

sudo add-apt-repository -y universe
sudo apt-add-repository -y non-free

sudo add-apt-repository -y ppa:agornostal/ulauncher
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo add-apt-repository -y ppa:nrbrtx/xorg-hotkeys

sudo apt update
sudo apt dist-upgrade -y
sudo apt autoremove --purge -y default-jre default-jdk transmission-gtk neofetch
sudo apt install -y ca-certificates curl gnupg wget gpg apt-transport-https software-properties-common

if [ $IS_PC ]; then
  wget -qO - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/google-chrome.gpg
  echo "deb [arch=$PC_ARCH signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | \
    sudo tee /etc/apt/sources.list.d/google-chrome.list
fi

# NodeJS
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [arch=$PC_ARCH signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | \
  sudo tee /etc/apt/sources.list.d/nodesource.list

# Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$UBUNTU_DISTRO_NAME/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$PC_ARCH signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$UBUNTU_DISTRO_NAME \
  $UBUNTU_CODENAME stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=$PC_ARCH signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | \
  sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

# MongoDB server
curl -fsSL https://pgp.mongodb.com/server-7.0.asc | \
  sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
  --dearmor
echo "deb [arch=$PC_ARCH signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg] https://repo.mongodb.org/apt/$UBUNTU_DISTRO_NAME $UBUNTU_CODENAME/mongodb-org/7.0 multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Signal desktop
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo "deb [arch=$PC_ARCH signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main" | \
  sudo tee /etc/apt/sources.list.d/signal-xenial.list
rm signal-desktop-keyring.gpg

# Teams for linux
sudo wget -qO /etc/apt/keyrings/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc
echo "deb [arch=$PC_ARCH signed-by=/etc/apt/keyrings/teams-for-linux.asc] https://repo.teamsforlinux.de/debian/ stable main" | \
  sudo tee /etc/apt/sources.list.d/teams-for-linux-packages.list

# Microsoft SQL Server
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg
curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
curl -fsSL https://packages.microsoft.com/config/$UBUNTU_DISTRO_NAME/$UBUNTU_VERSION/mssql-server-2022.list | \
  sudo tee /etc/apt/sources.list.d/mssql-server-2022.list

# PostgreSQL server
sudo install -d /usr/share/postgresql-common/pgdg
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
echo deb [arch=$PC_ARCH signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] \
  https://apt.postgresql.org/pub/repos/apt $UBUNTU_CODENAME-pgdg main | sudo tee /etc/apt/sources.list.d/pgdg.list
rm ACCC4CF8.asc

# MySQL server
wget 'https://repo.mysql.com//mysql-apt-config_0.8.30-1_all.deb' -O mysql-apt-config.deb
sudo dpkg -i ./mysql-apt-config.deb
rm mysql-apt-config.deb

sudo apt update

sudo apt install -y zsh code sqlitebrowser obs-studio gimp inkscape signal-desktop qbittorrent nemo-preview \
  mssql-server mongodb-org postgresql postgresql-contrib mysql-server mysql-client dotnet8 dotnet6 inkscape \
  gdebi gcc g++ clangd clang python3 python3-pip python3-venv nodejs git build-essential fastfetch filezilla ulauncher \
  libssl-dev libffi-dev python3-dev qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager evolution-ews \
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin teams-for-linux chromium evolution yaru-*

# Install theme, icons & cursors
wget 'https://github.com/ful1e5/apple_cursor/releases/download/v2.0.1/macOS.tar.xz' -O macOS.tar.xz
sudo tar -vxf macOS.tar.xz -C /usr/share/icons/
# Install & upply papirus folders
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C green --theme Papirus-Dark

# 'Install' wallpapers
wget 'https://512pixels.net/downloads/macos-wallpapers-6k/10-13-6k.jpg' -O macos-high-sierra.jpg
wget 'https://512pixels.net/downloads/macos-wallpapers-6k/10-11-6k.jpg' -O macos-el-capitan.jpg
sudo mkdir -p /usr/share/backgrounds/user
sudo mv macos-high-sierra.jpg /usr/share/backgrounds/user/macos-high-sierra.jpg
sudo mv macos-el-capitan.jpg /usr/share/backgrounds/user/macos-el-capitan.jpg

# Install Colibre Dark LibreOffice icon theme
git clone https://github.com/rizmut/libreoffice-style-colibre.git
./libreoffice-style-colibre/install-colibre-local.sh
rm -r libreoffice-style-colibre

if [ $IS_PC ] ; then
  sudo chmod u+x /usr/share/screen-resolution-extra/nvidia-polkit
  systemctl --user enable gamemoded && systemctl --user start gamemoded

  sudo apt install -y google-chrome-stable steam lutris vkbasalt mangohud

  wget 'https://github.com/Castro-Fidel/PortProton_dpkg/releases/download/portproton_1.4-1_amd64/portproton_1.4-1_amd64.deb' -O portproton.deb
  wget 'https://github.com/benjamimgois/goverlay/releases/download/1.1.1/goverlay_1_1_1.tar.xz' -O goverlay.tar.xz
  wget 'https://github.com/davidbannon/libqt6pas/releases/download/v6.2.8/libqt6pas6_6.2.8-1_amd64.deb'
  wget 'https://launcher.mojang.com/download/Minecraft.deb' -O Minecraft.deb
  wget 'https://client-updates-cdn77.badlion.net/BadlionClient' -O BadlionClient
  wget 'https://launcherupdates.lunarclientcdn.com/Lunar%20Client-3.2.9.AppImage' -O lunarclient.appimage

  chmod u+x lunarclient.appimage
  chmod u+x BadlionClient
  sudo mv lunarclient.appimage /opt/
  sudo mv BadlionClient /opt/

  sudo tar -xvf goverlay.tar.xz -C /opt/

  sudo apt install -y ./*.deb

  touch /home/$USER_NAME/.local/share/applications/Goverlay.desktop
  touch /home/$USER_NAME/.local/share/applications/BadlionClient.desktop
  touch /home/$USER_NAME/.local/share/applications/LunarClient.desktop

  echo \
  '
  [Desktop Entry]
  Type=Application
  Name=Goverlay
  Icon=goverlay
  Comment=GOverlay is an open source project aimed to create a Graphical UI to manage Vulkan/OpenGL overlays.
  Exec=/opt/goverlay
  Encoding=UTF-8
  Terminal=false
  Categories=Game;
  ' > /home/dennimi/.local/share/applications/Goverlay.desktop
  echo \
  '
  [Desktop Entry]
  Type=Application
  Name=Badlion Client
  Icon=BadlionClient
  Comment=The Best All-in-One Minecraft Mod Library.
  Exec=/opt/BadlionClient
  Encoding=UTF-8
  Terminal=false
  Categories=Game;
  ' > /home/dennimi/.local/share/applications/BadlionClient.desktop
  echo \
  '
  [Desktop Entry]
  Type=Application
  Name=Lunar Client
  Icon=lunarclient
  Comment=The #1 Free Minecraft Client.
  Exec=/opt/lunarclient.appimage
  Encoding=UTF-8
  Terminal=false
  Categories=Game;
  ' > /home/dennimi/.local/share/applications/LunarClient.desktop

  chmod +x /home/dennimi/.local/share/applications/Goverlay.desktop
  chmod +x /home/dennimi/.local/share/applications/BadlionClient.desktop
  chmod +x /home/dennimi/.local/share/applications/LunarClient.desktop

  flatpak install -y flathub com.leinardi.gwe
  flatpak update -y
fi

# Install zshrc config
cp -f .zshrc /home/$USER_NAME/

# Make ZSH as default shell
chsh -s $(which zsh) && sudo chsh -s $(which zsh)

#Install ZED text editor
curl -f https://zed.dev/install.sh | sh

# Download DEB apps
wget 'https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb' -O docker-desktop.deb
wget 'https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb' -O jdk-21.deb
wget 'https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb' -O dbeaver.deb
wget 'https://downloads.mongodb.com/compass/mongodb-compass_1.43.4_amd64.deb' -O mongodb-compass.deb
wget 'https://downloads.mongodb.com/compass/mongodb-mongosh_2.2.12_amd64.deb' -O mongoh.deb
wget 'https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb' -O onlyoffice.deb
wget 'https://github.com/localsend/localsend/releases/download/v1.15.1/LocalSend-1.15.1-linux-x86-64.deb' -O LocalSend.deb
wget 'https://discord.com/api/download?platform=linux&format=deb' -O discord.deb
wget 'https://anytype-release.fra1.cdn.digitaloceanspaces.com/anytype_0.41.1_amd64.deb' -O anytype.deb
wget 'https://cdn.zoom.us/prod/6.1.5.871/zoom_amd64.deb' -O zoom.deb
wget 'https://download2.gluonhq.com/scenebuilder/22.0.0/install/linux/SceneBuilder-22.0.0.deb' -O SceneBuilder.deb
wget 'https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community_8.0.38-1ubuntu24.04_amd64.deb' -O mysql-workbench-community.deb
wget 'https://download.virtualbox.org/virtualbox/7.0.20/virtualbox-7.0_7.0.20-163906~Ubuntu~noble_amd64.deb' -O virtualbox.deb
wget 'https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.5.1/gcm-linux_amd64.2.5.1.deb' -O gcm.deb

# Download tar.gz
wget 'https://download-cdn.jetbrains.com/datagrip/datagrip-2023.3.3.tar.gz' -O jetbrains-datagrip.tar.gz
wget 'https://download-cdn.jetbrains.com/idea/ideaIU-2023.3.2.tar.gz' -O jetbrains-idea.tar.gz
wget 'https://download-cdn.jetbrains.com/rider/JetBrains.Rider-2023.3.2.tar.gz' -O jetbrains-rider.tar.gz
wget 'https://eclipse.mirror.garr.it/oomph/epp/2023-12/R/eclipse-inst-jre-linux64.tar.gz' -O eclipse.tar.gz
wget 'https://td.telegram.org/tlinux/tsetup.4.16.8.tar.xz' -O telegram.tar.xz
wget 'https://dl.pstmn.io/download/latest/linux_64' -O postman.tar.gz
wget 'https://dl.google.com/go/go1.22.5.linux-amd64.tar.gz' -O golang.tar.gz
wget 'https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip' -O jetbrains-mono-font.zip
wget 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip' -O jetbrains-mono-nerdfonts-font.zip
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

# Install downloaded DEB apps
sudo apt install -y ./*.deb

# Install flatpak apps
flatpak install -y flathub com.github.eneshecan.WhatsAppForLinux
flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install -y flathub com.usebottles.bottles
flatpak install -y flathub com.skype.Client
flatpak update -y

# Extract tar.gz
sudo tar -vzxf jetbrains-datagrip.tar.gz -C /opt/
sudo tar -vzxf jetbrains-idea.tar.gz -C /opt/
sudo tar -vzxf jetbrains-rider.tar.gz -C /opt/
sudo tar -vxf telegram.tar.xz -C /opt/
sudo tar -vzxf postman.tar.gz -C /opt/
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -vxzf golang.tar.gz
tar -vzxf eclipse.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# Create dekstop file for postman
touch /home/$USER_NAME/.local/share/applications/postman.desktop
echo \
'
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Name=Postman
Comment=Supercharge your API workflow
Icon=postman
Exec="/opt/Postman/Postman"
Categories=Development;
' > /home/dennimi/.local/share/applications/Goverlay.desktop

# Download & install AppImages
wget 'https://download.kde.org/stable/krita/5.2.2/krita-5.2.2-x86_64.appimage' -O krita.appimage
wget 'https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=appimage'
mv 'index.html?app=desktop&platform=linux&variant=appimage' bitwarden.appimage
rm 'index.html?app=desktop&platform=linux&variant=appimage'
chmod u+x krita.appimage
chmod u+x bitwarden.appimage
sudo mv krita.appimage /opt/
sudo mv bitwarden.appimage /opt/

# Add menu entries for appimage programs
touch /home/dennimi/.local/share/applications/Bitwarden.desktop
touch /home/dennimi/.local/share/applications/Krita.desktop

echo \
'[Desktop Entry]
Type=Application
Name=Bitwarden
Icon=bitwarden
Comment=The password manager trusted by millions
Exec=/opt/bitwarden.appimage
Encoding=UTF-8
Terminal=false
Categories=Utility;
' > /home/dennimi/.local/share/applications/Bitwarden.desktop
echo \
'
[Desktop Entry]
Type=Application
Name=Krita
Icon=krita
Comment=Professional FREE and open source painting program.
Exec=/opt/krita.appimage
Encoding=UTF-8
Terminal=false
Categories=Graphics;
' > /home/dennimi/.local/share/applications/Krita.desktop

chmod +x /home/dennimi/.local/share/applications/Bitwarden.desktop
chmod +x /home/dennimi/.local/share/applications/Krita.desktop

# Install neovim config
git clone git@github.com:DennimiCode/NdVim.git /home/$USER_NAME/.config/nvim

# Use dark theme for MySQL workbench
git clone https://github.com/mleandrojr/mysql-workbench-dark-theme.git
sudo mv mysql-workbench-dark-theme/code_editor.xml /usr/share/mysql-workbench/data/

# Configure mssql server
sudo /opt/mssql/bin/mssql-conf setup

# Configure git credential manager
git config --global credential.credentialStore gpg
gpg --gen-key
pass init Denis
git-credential-manager configure

# Add current user to KVM & VirtualBox groups
sudo gpasswd -a $USER_NAME libvirt
sudo usermod -a -G vboxusers $USER_NAME
sudo usermod -a -G libvirt $USER_NAME

# Remove downloaded packages, archives & directories
rm *.deb
rm *.tar.gz
rm *.tar.xz
rm -rf mysql-workbench-dark-theme/

sudo apt autoremove
sudo apt autoclean

# Start installed services
sudo systemctl start mongod
sudo systemctl enable mongod
sudo systemctl status mongod

sudo ufw allow 53317

sudo dpkg-divert --package im-config --rename /usr/bin/ibus-daemon

# Extend swap file
sudo swapoff -a
sudo rm -f /swapfile
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

chmod u+x eclipse-installer/eclipse-inst
eclipse-installer/eclipse-inst
sudo rm -rf eclipse-installer
