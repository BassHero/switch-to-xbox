#!/bin/bash

# 1. Caso seu controle leve aproximadamente 60 segundos para começar a funcionar, esta versão do xboxdrv do github do buxit resolverá o seu problema.

cd ~/Downloads
git clone https://github.com/buxit/xboxdrv.git
cd xboxdrv
sudo apt install g++ libusb-1.0-0-dev pkg-config libudev-dev libboost-dev scons input-utils git x11proto-core-dev libdbus-1-dev glibc-tools libdbus-glib-1-dev
mv SConstruct SConstruct.old
wget https://raw.githubusercontent.com/buxit/xboxdrv/39a334fbc0482626455f417e97308e52aa8746a7/SConstruct
scons
sudo make install
