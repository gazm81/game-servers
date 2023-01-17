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
