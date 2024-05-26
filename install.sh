#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# username=$(id -u -n 1000)
# builddir=$(pwd)

# Update packages list and update system
apt update
apt upgrade -y

# Install nala
apt install nala -y

# add non free and contrib repo
nala install software-properties-common -y
apt-add-repository contrib non-free-firmware non-free
nala update
nala install make curl build-essential openssl libssl-dev unzip libwebkit2gtk-4.0-dev wget file libgtk-3-dev libayatana-appindicator3-dev librsvg2-dev gnupg  -y

# Use nala
# bash scripts/usenala

# install nvidia driver
nala install nvidia-driver -y

# install vlc and codec
nala install libavcodec-extra vlc -y

# install synaptic
nala install synaptic -y

# install vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft-archive-keyring.gpg
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
nala update
nala install code -y

# install git
nala install git -y
git config --global user.name "yourusername"
git config --global user.email "yourgituseremail@users.noreply.github.com"
ssh-keygen -t ed25519 -C "youremail@email.com" -N '' -f ~/.ssh/id_ed25519 <<< y


# install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
source ~/.bashrc
nvm install --lts
nvm use --lts

# install PostgresSQL
nala install postgresql postgresql-contrib -y
passwd postgres

# install mongodb
curl -fsSL https://pgp.mongodb.com/server-7.0.asc |sudo gpg  --dearmor -o /etc/apt/trusted.gpg.d/mongodb-server-7.0.gpg
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
nala update
nala install mongodb-org -y
systemctl start mongod
systemctl enable mongod

# install Tableplus
wget -qO - https://deb.tableplus.com/apt.tableplus.com.gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/tableplus-archive.gpg > /dev/null
add-apt-repository "deb [arch=amd64] https://deb.tableplus.com/debian/22 tableplus main"
nala update
nala install tableplus -y

# install flatpack
nala install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo






