#!/bin/bash

# 1. Configura o controles que quando conectado via bluetooth são reconhecidos 
# como Nintendo Switch Pro Controller, para serem reconhecido como controle de 
# Xbox 360, melhorando assim sua compatibilidade.

# 2. Links úteis:
# tutorial xboxdrv: https://steamcommunity.com/app/221410/discussions/0/558748653738497361/
# dkms-hid-nintendo https://github.com/nicman23/dkms-hid-nintendo
# joycond https://github.com/DanielOgorchock/joycond

# 3. Instalação do xboxdrv modificado tra não ter atraso no funcionamento do controle:

sudo apt install evtest xboxdrv -y

echo " "
read -p "pt_BR: Deseja instalar a versão xboxdrv que acelera o tempo de conexão?
Caso responda não e o controle fique demorando por volta de 60 segundos pra conectar, 
execute o instalador novamente e responda sim quando chegar nesta parte. S/N:

en_US: Would you like to install the xboxdrv version that speeds up connection time?
If you answer no and the gamepad takes around 60 seconds to works, run 
run the script again and answer Yes when you get to this part. Y/N: " xboxdrv_fast
echo "==================================================================="

if [ $xboxdrv_fast = s -o $xboxdrv_fast = y ]; then

	git clone https://github.com/buxit/xboxdrv.git
	cd xboxdrv
	sudo apt install g++ libusb-1.0-0-dev pkg-config libudev-dev libboost-dev scons input-utils git x11proto-core-dev libdbus-1-dev glibc-tools libdbus-glib-1-dev -y
	mv SConstruct SConstruct.old
	wget https://raw.githubusercontent.com/buxit/xboxdrv/39a334fbc0482626455f417e97308e52aa8746a7/SConstruct
scons
	sudo make install	
	cd ..	
			
fi
	
# 4. Instalação do dkms-hid-nintendo:

echo " "
read -p "pt_BR: Deseja instalar o dkms-hid-nintendo? 
Caso responda não e o controle não seja reconhecido ou alguns botões do controle não
funcionem, execute o instalador novamente e responda sim quando chegar nesta parte. S/N:

en_US: Would you like to install dkms-hid-nintendo?
If you answer no and the gamepad is not recognized or some buttons on the gamepad 
do not work, run the script again and answer yes when you get to this part. Y/N: " dkms_hid_nintendo
echo "==================================================================="
	
if [ $xboxdrv_fast = s -o $xboxdrv_fast = y ]; then

	echo " "
	echo "Clonando o repositório do dkms-hid-nintendo driver..."
	git clone https://github.com/nicman23/dkms-hid-nintendo
	cd dkms-hid-nintendo
	sudo dkms add .
	sudo dkms build nintendo -v 3.2
	echo "Instalando dkms-hid-nintendo driver..."
	sudo dkms install nintendo -v 3.2	
	cd ..
	
fi
	
# 5. Instalação do Joycond:

echo " "
read -p "pt_BR: Deseja instalar o Joycond? 
Caso responda não e o controle não seja reconhecido ou alguns botões do controle não 
funcionem, execute o instalador novamente e responda sim quando chegar nesta parte. S/N: 

en_US: Would you like to install Joycond?
If you answer no and the gamepad is not recognized or some buttons on the gamepad
do not work, run the script again and answer yes when you get to this part. Y/N:" joycond
echo "==================================================================="
	
if [ $xboxdrv_fast = s -o $xboxdrv_fast = y ]; then
	
	echo "Clonando o repositório do joycond..."
	git clone https://github.com/DanielOgorchock/joycond	
	cd joycond
	cmake .
	echo "Instalando dkms-hid-nintendo driver..."
	sudo make install
	sudo systemctl enable --now joycond
	cd ..

fi

# 6. Configurando o switch-to-xbox:

rm ~/.local/share/applications/switch-to-xbox.desktop
rm ~/switch-to-xbox.sh
chmod a+x switch-to-xbox.*
cp switch-to-xbox.sh ~
cp switch-to-xbox.desktop ~/.local/share/applications
mkdir ~/.local/share/icons
cp icons/switch-to-xbox-v*.png ~/.local/share/icons
