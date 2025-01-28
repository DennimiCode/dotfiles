#!/bin/bash

USER_NAME=$(whoami)
PC_ARCH=$(dpkg --print-architecture)
UBUNTU_CODENAME=$(source /etc/os-release && echo $UBUNTU_CODENAME)
UBUNTU_VERSION="24.04"
UBUNTU_DISTRO_NAME="ubuntu"
NODEJS_VERSION=20
IS_PC=false
IS_ADD_CHROME=false

# Exit from script if ran as root
if [[ $USER_NAME == "root" ]]; then
  echo ERROR: "Do not run this script as root user"
  exit 1
fi

# Setup this PC/Laptop as gaming or not
read -p "Is it PC (PC/Laptop for games)? (y/N): " PC_CONFIRM
if [[ $PC_CONFIRM == [yY] || $PC_CONFIRM == [yY][eE][sS] ]]; then
  IS_PC=true
fi

read -p "Do you want to add Google Chrome repository and install it? (y/N): " CHROME_ADD
if [[ $CHROME_ADD == [yY] || $CHROME_ADD == [yY][eE][sS] ]]; then
  IS_ADD_CHROME=true
fi

# Add universe component to all repositories
sudo add-apt-repository -y universe

# Update system
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y

# Remove unused packages
sudo apt autoremove --purge -y default-jre default-jdk transmission-gtk neofetch

# Install script pre-requirements
sudo apt install -y ca-certificates curl gnupg wget gpg apt-transport-https software-properties-common

# Add fastfetch ppa repository
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch

# Add nala repository
curl https://gitlab.com/volian/volian-archive/-/raw/main/install-nala.sh | bash

# Add google chrome repository if user want it
if [ $IS_ADD_CHROME == true ] ; then
  wget -qO - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/google-chrome.gpg
  echo "deb [arch=$PC_ARCH signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | \
    sudo tee /etc/apt/sources.list.d/google-chrome.list
fi

# Add Teams-for-Linux repository
sudo mkdir -p /etc/apt/keyrings
sudo wget -qO /etc/apt/keyrings/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc
echo "deb [signed-by=/etc/apt/keyrings/teams-for-linux.asc arch=$PC_ARCH] https://repo.teamsforlinux.de/debian/ stable main" | \
  sudo tee /etc/apt/sources.list.d/teams-for-linux-packages.list

# Add NodeJS repository
curl -fsSL https://deb.nodesource.com/setup_$NODEJS_VERSION.x | sudo bash -

# Add Visual Studio Code repository
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=$PC_ARCH signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | \
  sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

# Add Docker repository
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/$UBUNTU_DISTRO_NAME/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$PC_ARCH signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/$UBUNTU_DISTRO_NAME \
  $UBUNTU_CODENAME stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Add MongoDB repository
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
  sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
  --dearmor
echo \
  "deb [arch=$PC_ARCH signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/$UBUNTU_DISTRO_NAME \
  $UBUNTU_CODENAME/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list

# PostgreSQL server
sudo install -d /usr/share/postgresql-common/pgdg
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
echo deb [arch=$PC_ARCH signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] \
  https://apt.postgresql.org/pub/repos/apt $UBUNTU_CODENAME-pgdg main | sudo tee /etc/apt/sources.list.d/pgdg.list
rm ACCC4CF8.asc

# MySQL server
wget 'https://repo.mysql.com//mysql-apt-config_0.8.33-1_all.deb' -O mysql-apt-config.deb
sudo dpkg -i ./mysql-apt-config.deb
rm mysql-apt-config.deb

# Update apt cache
sudo apt update

# Install additional software, packages & etc.
sudo apt install -y zsh code sqlitebrowser obs-studio gimp inkscape qbittorrent remmina chromium teams-for-linux\
  mongodb-org postgresql postgresql-contrib mysql-server mysql-client dotnet8 inkscape tmux evolution-ews piper \
  gdebi gcc g++ clangd clang python3 python3-pip python3-venv nodejs git build-essential fastfetch filezilla nala \
  libssl-dev libffi-dev python3-dev qemu-kvm libvirt-daemon-system libvirt-clients virt-manager evolution acpi \
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin wl-clipboard

# Install google chrome if user want it
if [ $IS_ADD_CHROME == true ] ; then
  sudo apt install -y google-chrome-stable
fi

#Install ZED text editor
curl -f https://zed.dev/install.sh | sh

# Install flatpak apps
flatpak install -y flathub com.ktechpit.whatsie
flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install -y flathub com.usebottles.bottles
flatpak install -y flathub com.skype.Client
flatpak install -y flathub com.discordapp.Discord

# Download native pre-build applications
wget 'https://td.telegram.org/tlinux/tsetup.5.10.3.tar.xz' -O telegram.tar.xz
wget 'https://dl.pstmn.io/download/latest/linux_64' -O postman.tar.gz
wget 'https://dl.google.com/go/go1.23.5.linux-amd64.tar.gz' -O go.linux-amd64.tar.gz
wget 'https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz' -O nvim-linux64.tar.gz

# "Install" native pre-build applications
sudo tar -vxf telegram.tar.xz -C /opt/
sudo tar -vzxf postman.tar.gz -C /opt/
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go.linux-amd64.tar.gz
sudo rm -rf /opt/nvim && sudo tar -C /opt -xzf nvim-linux64.tar.gz

# Download DEB applications
wget 'https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb' -O docker-desktop.deb
wget 'https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb' -O jdk-21.deb
wget 'https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb' -O dbeaver.deb
wget 'https://downloads.mongodb.com/compass/mongodb-compass_1.45.1_amd64.deb' -O mongodb-compass.deb
wget 'https://downloads.mongodb.com/compass/mongodb-mongosh_2.3.8_amd64.deb' -O mongoh.deb
wget 'https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb' -O onlyoffice.deb
wget 'https://github.com/localsend/localsend/releases/download/v1.16.1/LocalSend-1.16.1-linux-x86-64.deb' -O LocalSend.deb
wget 'https://anytype-release.fra1.cdn.digitaloceanspaces.com/anytype_0.44.0_amd64.deb' -O anytype.deb
wget 'https://zoom.us/client/6.3.6.6315/zoom_amd64.deb' -O zoom.deb
wget 'https://download2.gluonhq.com/scenebuilder/22.0.0/install/linux/SceneBuilder-23.0.1.deb' -O SceneBuilder.deb

# Install DEB applications
sudo apt install -y ./*.deb

# Create desktop file for postman
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

# Mark it as trusted
chmod +x /home/$USER_NAME/.local/share/applications/Postman.desktop

# Download & install AppImage programs
wget 'https://download.kde.org/stable/krita/5.2.6/krita-5.2.6-x86_64.appimage' -O Krita.AppImage
wget "https://vault.bitwarden.com/download/?app=desktop&platform=linux" -O Bitwarden.AppImage
wget 'https://apps.webinar.ru/desktop/latest/mts-link-desktop.AppImage' -O MTSLink.AppImage

chmod +x Krita.AppImage
chmod +x Bitwarden.AppImage
chmod +x MTSLink.AppImage

mkdir -p /home/$USER_NAME/Applications
mkdir -p /home/$USER_NAME/Applications/icons

cp -r ./icons/* /home/$USER_NAME/Applications/icons/

mv ./*.AppImage /home/$USER_NAME/Applications/

# Create desktop files for AppImage programs
touch /home/$USER_NAME/.local/share/applications/Bitwarden.desktop
touch /home/$USER_NAME/.local/share/applications/Krita.desktop
touch /home/$USER_NAME/.local/share/applications/MTSLink.desktop

echo \
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
Exec=/home/${USER_NAME}/Applications/Krita.AppImage
Encoding=UTF-8
Terminal=false
Categories=Graphics;" > /home/$USER_NAME/.local/share/applications/Krita.desktop

echo \
"[Desktop Entry]
Type=Application
Name=MTS Link
Icon=/home/${USER_NAME}/Applications/icons/mts-link-icon.png
Comment=Экосистема сервисов для бизнес‑коммуникаций и совместной работы
Exec=/home/${USER_NAME}/Applications/MTSLink.AppImage
Encoding=UTF-8
Terminal=false
Categories=Network;" > /home/$USER_NAME/.local/share/applications/MTSLink.desktop

# Mark them as trusted
chmod +x /home/$USER_NAME/.local/share/applications/Bitwarden.desktop
chmod +x /home/$USER_NAME/.local/share/applications/Krita.desktop
chmod +x /home/$USER_NAME/.local/share/applications/MTSLink.desktop

# Install cursors theme
wget 'https://github.com/ful1e5/apple_cursor/releases/download/v2.0.1/macOS.tar.xz' -O macOS.tar.xz
sudo tar -vxf macOS.tar.xz -C /usr/share/icons/

# Install gaming software
if [ $IS_PC == true ] ; then
  sudo apt install -y steam lutris vkbasalt mangohud gamemode gamemode-deamon

  systemctl --user enable gamemoded && systemctl --user start gamemoded

  wget 'https://github.com/Castro-Fidel/PortProton_dpkg/releases/download/portproton_1.7-3_amd64/portproton_1.7-3_amd64.deb' -O portproton.deb
  wget 'https://github.com/benjamimgois/goverlay/releases/download/1.2/goverlay.tar.xz' -O goverlay.tar.xz
  wget 'https://github.com/flightlessmango/MangoHud/releases/download/v0.7.2/MangoHud-0.7.2.r0.g7b80f73.tar.gz' -O mangohud.tar.gz
  wget 'https://github.com/davidbannon/libqt6pas/releases/download/v6.2.8/libqt6pas6_6.2.8-1_amd64.deb'
  wget 'https://launcher.mojang.com/download/Minecraft.deb' -O Minecraft.deb
  wget 'https://client-updates-cdn77.badlion.net/BadlionClient' -O BadlionClient.AppImage
  wget 'https://launcherupdates.lunarclientcdn.com/Lunar%20Client-3.2.9.AppImage' -O LunarClient.AppImage

  mkdir -p /home/$USER_NAME/Applications
  mv ./*.AppImage /home/$USER_NAME/Applications/

  sudo apt install -y ./*.deb

  sudo tar -xvf goverlay.tar.xz -C /opt/
  tar -xvzf mangohud.tar.gz
  chmod +x ./mangohud/mangohud-setup.sh
  ./mangohud/mangohud-setup.sh install

  chmod +x BadlionClient.AppImage
  chmod +x LunarClient.AppImage

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
  Exec=/home/${USER_NAME}/Applications/BadlionClient.AppImage
  Encoding=UTF-8
  Terminal=false
  Categories=Game;" > /home/$USER_NAME/.local/share/applications/BadlionClient.desktop

  echo \
  "[Desktop Entry]
  Type=Application
  Name=Lunar Client
  Icon=lunarclient
  Comment=The #1 Free Minecraft Client.
  Exec=/home/${USER_NAME}/Applications/LunarClient.AppImage
  Encoding=UTF-8
  Terminal=false
  Categories=Game;" > /home/$USER_NAME/.local/share/applications/LunarClient.desktop

  chmod +x /home/$USER_NAME/.local/share/applications/Goverlay.desktop
  chmod +x /home/$USER_NAME/.local/share/applications/BadlionClient.desktop
  chmod +x /home/$USER_NAME/.local/share/applications/LunarClient.desktop
fi

# Install zshrc config
cp -f ./.zshrc /home/$USER_NAME/.zshrc

# Install NeoVim config
mkdir -p /home/$USER_NAME/.config/nvim
git clone git@github.com:DennimiCode/NdVim.git /home/$USER_NAME/.config/nvim

# Install Alacritty terminal config
mkdir -p /home/$USER_NAME/.config/alacritty
cp ./alacritty.toml /home/$USER_NAME/.config/alacritty/

# Install Tmux config
cp -f ./.tmux.conf /home/$USER_NAME/.tmux.conf

# Install ideavim config (VIM mode plugin for JetBrains IDEs)
cp -f ./.ideavimrc /home/$USER_NAME/.ideavimrc

# Make ZSH as default shell
chsh -s $(which zsh) && sudo chsh -s $(which zsh)

# Allow current user use KVM virtual machines
sudo gpasswd -a $USER_NAME libvirt
sudo usermod -aG libvirt $USER_NAME

# Remove downloaded packages, archives & etc.
rm *.deb
rm *.tar.gz
rm *.tar.xz

# Remove deb packages, downloaded by APT & remove unused dependencies
sudo apt autoremove -y
sudo apt autoclean -y

# Start installed services
sudo systemctl start mongod
sudo systemctl enable mongod
sudo systemctl status mongod

# Add rule to Ubuntu firewall for LocalSend proper work
sudo ufw allow 53317

# Disable iBus
sudo dpkg-divert --package im-config --rename /usr/bin/ibus-daemon

# Extend swap file
sudo swapoff -a
sudo rm -f /swapfile
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
