#!/bin/bash

# 1. Configura o controles que quando conectado via bluetooth são reconhecidos 
# como Nintendo Switch Pro Controller, para serem reconhecido como controle de 
# Xbox 360, melhorando assim sua compatibilidade.

# 2. Links úteis:
# tutorial xboxdrv: https://steamcommunity.com/app/221410/discussions/0/558748653738497361/
# dkms-hid-nintendo https://github.com/nicman23/dkms-hid-nintendo
# joycond https://github.com/DanielOgorchock/joycond

# 3. Instalação do xboxdrv modificado tra não ter atraso no funcionamento do controle:

xboxdrv=/usr/bin/xboxdrv

if [ -e $xboxdrv ]; then

	sudo apt install xboxdrv -y
	
fi
	
read -p "Deseja instalar a versão xboxdrv que acelera o tempo de conexão?
Caso responda não e o controle fique demorando por volta de 60
segundos pra conectar, execute o instalador novamente e responda
sim quando chegar nesta parte.
S/N: " xboxdrv_fast	

if [ $xboxdrv_fast = s ]; then

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

read -p "Deseja instalar o dkms-hid-nintendo? 
Caso responda não e o controle não seja reconhecido
ou alguns botões do controle não funcionem, execute
o instalador novamente e respondasim quando chegar
nesta parte. S/N: " dkms_hid_nintendo
	
if [ $dkms_hid_nintendo = s ]; then

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

read -p "Deseja instalar o Joycond? 
Caso responda não e o controle não seja reconhecido
ou alguns botões do controle não funcionem, execute
o instalador novamente e responda sim quando chegar
nesta parte. S/N: " joycond
	
if [ $joycond = s ]; then
	
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

echo "#!/bin/bash

# Links úteis:
# Tutorial xboxdrv: https://steamcommunity.com/app/221410/discussions/0/558748653738497361/
# dkms-hid-nintendo: https://github.com/nicman23/dkms-hid-nintendo
# joycond: https://github.com/DanielOgorchock/joycond

read -p "O controle está ligado e pareado? S/N: " controle_ligado

if [ $controle_ligado = s ]; then

	echo "Primeiro precisamos saber qual é o número event do controle."
	echo "============== Nintendo Switch Pro Controller =============="

	timeout -k 1 1 evtest	

	read -p "Digite apenas o número do event correspondente ao controle: " event

	xboxdrv --evdev "/dev/input/event$event" --evdev-absmap ABS_X=x1,ABS_Y=y1,ABS_RX=x2,ABS_RY=y2,ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y, --axismap -Y1=Y1,-Y2=Y2 --evdev-keymap BTN_SOUTH=a,BTN_EAST=b,BTN_WEST=x,BTN_NORTH=y,BTN_TL=lb,BTN_TL2=lt,BTN_TR=rb,BTN_TR2=rt,BTN_SELECT=back,BTN_START=start,BTN_MODE=guide,BTN_THUMBL=tl,BTN_THUMBR=tr, --mimic-xpad

else

	echo "Você precisa ligar o controle primeiro."
	echo "Ligue o controle e execute o script novamente."

fi
" >> switch-to-xbox.sh

echo "[Desktop Entry]
Encoding=UTF-8
Name=Switch to Xbox
GenericName=Switch to Xbox
Exec=./switch-to-xbox.sh
Icon=switch-to-xbox-v2.png
Type=Application
Terminal=true
X-GNOME-Autostart-enabled=true
X-KDE-autostart-after=panel
X-KDE-StartupNotify=false
X-DCOP-ServiceType=Unique
X-KDE-UniqueApplet=true
X-KDE-autostart-condition=AutoStart:true
Categories=Game;
Comment=Emulate Xbox 360 Controller
" >> switch-to-xbox.desktop

chmod a+x switch-to-xbox.*
cp switch-to-xbox.sh ~
cp switch-to-xbox.desktop ~/.local/share/applications
wget https://github.com/BassHero/switch-to-xbox/blob/main/icons/switch-to-xbox-v2.png
cp switch-to-xbox-v2.png ~/.local/share/icons
