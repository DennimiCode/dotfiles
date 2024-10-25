#!/bin/bash

USER_NAME=$(whoami)
IS_PC=false
PC_ARCH=$(dpkg --print-architecture)
UBUNTU_CODENAME=$(source /etc/os-release && echo $UBUNTU_CODENAME)
UBUNTU_VERSION="24.04"
UBUNTU_DISTRO_NAME="ubuntu"
NODEJS_VERSION=20

# Setup this PC as gaming or not
read -p "Is it PC (PC/Laptop for games)? (y/N): " PC_CONFIRM
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

if [ $IS_PC == true ]; then
  wget -qO - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/google-chrome.gpg
  echo "deb [arch=$PC_ARCH signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | \
    sudo tee /etc/apt/sources.list.d/google-chrome.list
fi

# NodeJS
curl -fsSL https://deb.nodesource.com/setup_$NODEJS_VERSION.x | sudo bash -

# Docker
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/$UBUNTU_DISTRO_NAME/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$PC_ARCH signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/$UBUNTU_DISTRO_NAME \
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
echo "deb [arch=$PC_ARCH signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg] https://repo.mongodb.org/apt/$UBUNTU_DISTRO_NAME jammy/mongodb-org/7.0 multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Teams for linux
sudo wget -qO /etc/apt/keyrings/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc
echo "deb [arch=$PC_ARCH signed-by=/etc/apt/keyrings/teams-for-linux.asc] https://repo.teamsforlinux.de/debian/ stable main" | \
  sudo tee /etc/apt/sources.list.d/teams-for-linux-packages.list

# Microsoft SQL Server
# Disabled until MS SQL Server is upgraded to Ubuntu 24.04
# curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg
# curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
# curl -fsSL https://packages.microsoft.com/config/$UBUNTU_DISTRO_NAME/$UBUNTU_VERSION/mssql-server-2022.list | \
#   sudo tee /etc/apt/sources.list.d/mssql-server-2022.list

# PostgreSQL server
sudo install -d /usr/share/postgresql-common/pgdg
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
echo deb [arch=$PC_ARCH signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] \
  https://apt.postgresql.org/pub/repos/apt $UBUNTU_CODENAME-pgdg main | sudo tee /etc/apt/sources.list.d/pgdg.list
rm ACCC4CF8.asc

# MySQL server
wget 'https://repo.mysql.com//mysql-apt-config_0.8.32-1_all.deb' -O mysql-apt-config.deb
sudo dpkg -i ./mysql-apt-config.deb
rm mysql-apt-config.deb

sudo apt update

sudo apt install -y zsh code sqlitebrowser obs-studio gimp inkscape qbittorrent nemo-preview ulauncher remmina flameshot \
  mongodb-org postgresql postgresql-contrib mysql-server mysql-client dotnet8 inkscape tmux alacritty evolution-ews \
  gdebi gcc g++ clangd clang python3 python3-pip python3-venv nodejs git build-essential fastfetch filezilla redshift \
  libssl-dev libffi-dev python3-dev qemu-kvm libvirt-daemon-system libvirt-clients virt-manager evolution xclip tlp \
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin teams-for-linux chromium yaru-*

# Install theme, icons & cursors
wget 'https://github.com/ful1e5/apple_cursor/releases/download/v2.0.1/macOS.tar.xz' -O macOS.tar.xz
sudo tar -vxf macOS.tar.xz -C /usr/share/icons/
# Install & upply papirus folders
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C green --theme Papirus-Dark

# Install Ulauncher theme
git clone https://github.com/lighttigerXIV/ulauncher-adwaita-gtk4/
mkdir -p ~/.config/ulauncher/user-themes/
cp -r ./ulauncher-adwaita-gtk4/src/* ~/.config/ulauncher/user-themes/
rm -r ./ulauncher-adwaita-gtk4

# 'Install' wallpapers
wget 'https://512pixels.net/downloads/macos-wallpapers-6k/10-13-6k.jpg' -O macos-high-sierra.jpg
wget 'https://512pixels.net/downloads/macos-wallpapers-6k/10-11-6k.jpg' -O macos-el-capitan.jpg
sudo mkdir -p /usr/share/backgrounds/user
sudo mv macos-high-sierra.jpg /usr/share/backgrounds/user/macos-high-sierra.jpg
sudo mv macos-el-capitan.jpg /usr/share/backgrounds/user/macos-el-capitan.jpg

if [ $IS_PC == true ] ; then
  systemctl --user enable gamemoded && systemctl --user start gamemoded

  sudo apt install -y google-chrome-stable steam lutris vkbasalt

  wget 'https://github.com/Castro-Fidel/PortProton_dpkg/releases/download/portproton_1.4-1_amd64/portproton_1.4-1_amd64.deb' -O portproton.deb
  wget 'https://github.com/benjamimgois/goverlay/releases/download/1.1.1/goverlay_1_1_1.tar.xz' -O goverlay.tar.xz
  wget 'https://github.com/flightlessmango/MangoHud/releases/download/v0.7.2/MangoHud-0.7.2.r0.g7b80f73.tar.gz' -O mangohud.tar.gz
  wget 'https://github.com/davidbannon/libqt6pas/releases/download/v6.2.8/libqt6pas6_6.2.8-1_amd64.deb'
  wget 'https://launcher.mojang.com/download/Minecraft.deb' -O Minecraft.deb
  wget 'https://client-updates-cdn77.badlion.net/BadlionClient' -O BadlionClient.AppImage
  wget 'https://launcherupdates.lunarclientcdn.com/Lunar%20Client-3.2.9.AppImage' -O LunarClient.AppImage

  chmod +x BadlionClient.AppImage
  chmod +x LunarClient.AppImage

  mkdir -p /home/$USER_NAME/Applications

  mv ./*.AppImage /home/$USER_NAME/Applications/

  sudo tar -xvf goverlay.tar.xz -C /opt/
  tar -xvzf mangohud.tar.gz -C ./mangohud/
  ./mangohud/mangohud-setup.sh

  sudo apt install -y ./*.deb

  touch /home/$USER_NAME/.local/share/applications/Goverlay.desktop
  touch /home/$USER_NAME/.local/share/applications/BadlionClient.desktop
  touch /home/$USER_NAME/.local/share/applications/LunarClient.desktop

  echo \
  "[Desktop Entry]
  Type=Application
  Name=Goverlay
  Icon=goverlay
  Comment=GOverlay is an open source project aimed to create a Graphical UI to manage Vulkan/OpenGL overlays.
  Exec=/opt/goverlay
  Encoding=UTF-8
  Terminal=false
  Categories=Game;" > /home/$USER_NAME/.local/share/applications/Goverlay.desktop

  echo \
  "[Desktop Entry]
  Type=Application
  Name=Badlion Client
  Icon=BadlionClient
  Comment=The Best All-in-One Minecraft Mod Library.
  Exec=/home/${$USER_NAME}/Applications/BadlionClient.AppImage
  Encoding=UTF-8
  Terminal=false
  Categories=Game;" > /home/$USER_NAME/.local/share/applications/BadlionClient.desktop

  echo \
  "[Desktop Entry]
  Type=Application
  Name=Lunar Client
  Icon=lunarclient
  Comment=The #1 Free Minecraft Client.
  Exec=/home/${$USER_NAME}/Applications/LunarClient.AppImage
  Encoding=UTF-8
  Terminal=false
  Categories=Game;" > /home/$USER_NAME/.local/share/applications/LunarClient.desktop

  chmod +x /home/$USER_NAME/.local/share/applications/Goverlay.desktop
  chmod +x /home/$USER_NAME/.local/share/applications/BadlionClient.desktop
  chmod +x /home/$USER_NAME/.local/share/applications/LunarClient.desktop
fi

# Install zshrc config
cp -f .zshrc /home/$USER_NAME/.zshrc

# Make ZSH as default shell
chsh -s $(which zsh) && sudo chsh -s $(which zsh)

#Install ZED text editor
curl -f https://zed.dev/install.sh | sh

# Download DEB apps
wget 'https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb' -O docker-desktop.deb
wget 'https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb' -O jdk-21.deb
wget 'https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb' -O dbeaver.deb
wget 'https://downloads.mongodb.com/compass/mongodb-compass_1.43.4_amd64.deb' -O mongodb-compass.deb
wget 'https://downloads.mongodb.com/compass/mongodb-mongosh_2.3.2_amd64.deb' -O mongoh.deb
wget 'https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb' -O onlyoffice.deb
wget 'https://github.com/localsend/localsend/releases/download/v1.15.4/LocalSend-1.15.4-linux-x86-64.deb' -O LocalSend.deb
wget 'https://anytype-release.fra1.cdn.digitaloceanspaces.com/anytype_0.42.5_amd64.deb' -O anytype.deb
wget 'https://cdn.zoom.us/prod/6.1.11.1545/zoom_amd64.deb' -O zoom.deb
wget 'https://download2.gluonhq.com/scenebuilder/22.0.0/install/linux/SceneBuilder-22.0.0.deb' -O SceneBuilder.deb
wget 'https://download.virtualbox.org/virtualbox/7.0.20/virtualbox-7.0_7.0.20-163906~Ubuntu~noble_amd64.deb' -O virtualbox.deb

# Download tar.gz
wget 'https://td.telegram.org/tlinux/tsetup.5.4.0.tar.xz' -O telegram.tar.xz
wget 'https://dl.pstmn.io/download/latest/linux_64' -O postman.tar.gz
wget 'https://dl.google.com/go/go1.23.2.linux-amd64.tar.gz' -O go.linux-amd64.tar.gz
wget 'https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip' -O jetbrains-mono-font.zip
wget 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip' -O jetbrains-mono-nerdfonts-font.zip
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

# Install downloaded DEB apps
sudo apt install -y ./*.deb

# Install flatpak apps
flatpak install -y flathub com.ktechpit.whatsie
flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install -y flathub com.usebottles.bottles
flatpak install -y flathub com.skype.Client
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.github.d4nj1.tlpui
flatpak install -y flathub com.gluonhq.SceneBuilder
flatpak update -y

# Extract tar.gz
sudo tar -vxf telegram.tar.xz -C /opt/
sudo tar -vzxf postman.tar.gz -C /opt/
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go.linux-amd64.tar.gz
tar -vzxf eclipse.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# Create dekstop file for postmanflatpak install flathub com.gluonhq.SceneBuilderflatpak install flathub com.gluonhq.SceneBuilderflatpak install flathub com.gluonhq.SceneBuilderflatpak install flathub com.gluonhq.SceneBuilder
touch /home/$USER_NAME/.local/share/applications/Postman.desktop
echo \
"[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Name=Postman
Comment=Supercharge your API workflow
Icon=postman
Exec=/opt/Postman/Postman
Categories=Development;" > /home/$USER_NAME/.local/share/applications/Postman.desktop

# Download & install AppImages
wget 'https://download.kde.org/stable/krita/5.2.2/krita-5.2.2-x86_64.appimage' -O Krita.AppImage
wget "https://vault.bitwarden.com/download/?app=desktop&platform=linux" -O Bitwarden.AppImage
wget 'https://apps.webinar.ru/desktop/latest/mts-link-desktop.AppImage' -O MTSLink.AppImage

chmod +x Krita.AppImage
chmod +x Bitwarden.AppImage
chmod +x MTSLink.AppImage

mkdir -p /home/$USER_NAME/Applications
mkdir -p /home/$USER_NAME/Applications/icons

cp -r ./icons/* /home/$USER_NAME/Applications/icons/

mv ./*.AppImage /home/$USER_NAME/Applications/

# Add menu entries for appimage programs
touch /home/$USER_NAME/.local/share/applications/Bitwarden.desktop
touch /home/$USER_NAME/.local/share/applications/Krita.desktop
touch /home/$USER_NAME/.local/share/applications/MTSLink.desktop

echo \
$(printf
"[Desktop Entry]
Type=Application
Name=Bitwarden
Icon=bitwarden
Comment=The password manager trusted by millions
Exec=/home/${USER_NAME}/Applications/Bitwarden.AppImage
Encoding=UTF-8
Terminal=false
Categories=Utility;" > /home/$USER_NAME/.local/share/applications/Bitwarden.desktop

echo \
"[Desktop Entry]
Type=Application
Name=Krita
Icon=krita
Comment=Professional FREE and open source painting program.
Exec=/home/${USER_NAME}/Applications/Kita.AppImage
Encoding=UTF-8
Terminal=false
Categories=Graphics;" > /home/$USER_NAME/.local/share/applications/Krita.desktop

echo \
"[Desktop Entry]
Type=Application
Name=MTS Link
Icon=~/Applications/icons/mts-link-icon.png
Comment=Экосистема сервисов для бизнес‑коммуникаций и совместной работы
Exec=/home/${USER_NAME}/Applications/MTSLink.AppImage
Encoding=UTF-8
Terminal=false
Categories=Network;" > /home/$USER_NAME/.local/share/applications/MTSLink.desktop

chmod +x /home/$USER_NAME/.local/share/applications/Bitwarden.desktop
chmod +x /home/$USER_NAME/.local/share/applications/Krita.desktop
chmod +x /home/$USER_NAME/.local/share/applications/MTSLink.desktop

# Install neovim config
mkdir /home/$USER_NAME/.config/nvim
git clone git@github.com:DennimiCode/NdVim.git /home/$USER_NAME/.config/nvim

# Configure mssql server
# sudo /opt/mssql/bin/mssql-conf setup

# Add current user to KVM & VirtualBox groups
sudo gpasswd -a $USER_NAME libvirt
sudo usermod -a -G vboxusers $USER_NAME
sudo usermod -a -G libvirt $USER_NAME

# Remove downloaded packages, archives & directories
rm *.deb
rm *.tar.gz
rm *.tar.xz

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
