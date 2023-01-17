## Set vars

InstallerForgeName="minecraftforge_installer.1.19.2"
Link="https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.2-43.1.57/forge-1.19.2-43.1.57-installer.jar"
ModpackLink="https://mediafilez.forgecdn.net/files/4167/509/Better+MC+FORGE+Server+Pack+1.19.2+v11.zip"

## Install Prereqs

apt install -y wget
apt install -y openjdk-18-jdk
apt install -y unzip
apt install -y git
apt install -y build-essential

# Create Minecraft User for Your Security

useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft

## Install forge

cd /opt/minecraft

su "minecraft" -c "wget -O '$InstallerForgeName'.jar '$Link'"
su "minecraft" -c "chmod +x '$InstallerForgeName'.jar"
su "minecraft" -c "java -jar '$InstallerForgeName'.jar --installServer"
su "minecraft" -c "./run.sh"

su "minecraft" -c "cp /vagrant/files/eula.txt /opt/minecraft/"
su "minecraft" -c "cp /vagrant/files/server.properties /opt/minecraft/"

## Install Mods

su "minecraft" -c "wget '$ModpackLink'"
su "minecraft" -c "unzip Better+MC+FORGE+Server+Pack+1.19.2+v11.zip"

su "minecraft" -c "mv ./Better\ MC\ FORGE\ Server\ Pack\ 1.19.2/mods/* ./mods/"
su "minecraft" -c "mv ./Better\ MC\ FORGE\ Server\ Pack\ 1.19.2/config/* ./config/"
su "minecraft" -c "rm -rf ./Better\ MC\ FORGE\ Server\ Pack\ 1.19.2/mods/"
su "minecraft" -c "rm -rf ./Better\ MC\ FORGE\ Server\ Pack\ 1.19.2/config/"
su "minecraft" -c "mv ./Better\ MC\ FORGE\ Server\ Pack\ 1.19.2/* ."
su "minecraft" -c "rm -rf ./Better\ MC\ FORGE\ Server\ Pack\ 1.19.2/"
chmod 764 ./start.sh

## Install rcon

mkdir tools
cd ./tools
git clone https://github.com/Tiiffi/mcrcon.git
cd ./mcrcon
gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c
cd ../..

## Run as as service

cp /vagrant/files/minecraft.service /etc/systemd/system/minecraft.service
systemctl start minecraft
systemctl status  minecraft
systemctl enable  minecraft
