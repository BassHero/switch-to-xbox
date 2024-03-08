#!/bin/bash

# 1. Configura o controle EasySMX ESM-4108, que quando conectado via bluetooth é reconhecido como Nintendo Switch Pro Controller, para ser reconhecido como controle de Xbox 360, melhorando assim sua compatibilidade.

# 2. Links úteis:
# tutorial xboxdrv: https://steamcommunity.com/app/221410/discussions/0/558748653738497361/
# dkms-hid-nintendo https://github.com/nicman23/dkms-hid-nintendo
# joycond https://github.com/DanielOgorchock/joycond

read -p "O controle está ligado? S/N: " controle_ligado

if [ $controle_ligado = s ]; then
	
	echo "
	Primeiro precisamos saber qual é o número event do controle. 
	Uma janela do terminal se abrirá e aparecerá nome abaixo:
	============== Nintendo Switch Pro Controller ==============
	Este nome acima será seguido do número do event. 
	Guarde esse número.	"

	gnome-terminal -- evtest
	
	read -p "Digite apenas o número do event: " event		
	
	xboxdrv --evdev "/dev/input/event$event" --evdev-absmap ABS_X=x1,ABS_Y=y1,ABS_RX=x2,ABS_RY=y2,ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y, --axismap -Y1=Y1,-Y2=Y2 --evdev-keymap BTN_SOUTH=a,BTN_EAST=b,BTN_WEST=x,BTN_NORTH=y,BTN_TL=lb,BTN_TL2=lt,BTN_TR=rb,BTN_TR2=rt,BTN_SELECT=back,BTN_START=start,BTN_MODE=guide,BTN_THUMBL=tl,BTN_THUMBR=tr, --mimic-xpad	
	
else
	echo "
	Você precisa ligar o controle primeiro. 
	Ligue o controle e execute o script novamente.
	"
	
fi

# xboxdrv --evdev 24 --evdev-absmap [ABS MAP] --axismap [AXIS MAP] --evdev-keymap [BUTTONS MAP] --mimic-xpad --silent &
