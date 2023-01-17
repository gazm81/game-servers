## Set vars

DownloadPath="https://minecraft.azureedge.net/bin-linux/bedrock-server-1.19.51.01.zip"

## Install Prereqs

apt install -y unzip
apt install -y curl
apt install -y tmux
apt install -y git
apt install -y wget

# Create Minecraft User for Your Security

adduser --system --home /opt/minecraft minecraft
addgroup --system minecraft
adduser minecraft minecraft
chsh --shell /bin/bash minecraft

## Download Bedrock

cd /opt/minecraft
su "minecraft" -c "wget '$DownloadPath'"
su "minecraft" -c "unzip bedrock-server*.zip"

# Configure

su "minecraft" -c "cp /vagrant/files/start.sh /opt/minecraft/"
su "minecraft" -c "cp /vagrant/files/stop.sh /opt/minecraft/"

su "minecraft" -c "chmod +x /opt/minecraft/start.sh"
su "minecraft" -c "chmod +x /opt/minecraft/stop.sh"

#su "minecraft" -c "cp /vagrant/files/eula.txt /opt/minecraft/"
#su "minecraft" -c "cp /vagrant/files/server.properties /opt/minecraft/"

## Run as as service

cp /vagrant/files/minecraft.service /etc/systemd/system/minecraft.service
systemctl start minecraft
systemctl status  minecraft
systemctl enable  minecraft

# Attach to the console

# sudo -s -u minecraft
# tmux attach
