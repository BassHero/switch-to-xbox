#!/bin/bash

# Links úteis:
# Tutorial xboxdrv: https://steamcommunity.com/app/221410/discussions/0/558748653738497361/
# dkms-hid-nintendo: https://github.com/nicman23/dkms-hid-nintendo
# joycond: https://github.com/DanielOgorchock/joycond

read -p "pt_BR: O controle está ligado e pareado? S/N: 
en_US: Is the gamepad on and paired? Y/N: " controle_ligado

if [ $controle_ligado = s -o $controle_ligado = y ]; then

	echo " "
	echo "pt_BR: Primeiro precisamos saber qual é o número event do controle."
	echo "en_US: Firstly we need know who is the gamepad event number."
	echo " "
	echo "================= Nintendo Switch Pro Controller =================="
	echo " "

	timeout -k 1 1 evtest	
	# futuramente quero automatizar a captura do número do event.

	read -p "
	
pt_BR: Digite apenas o número do event correspondente ao controle: 
en_US: Type just the event number related to gamepad: " event

	xboxdrv --evdev "/dev/input/event$event" --evdev-absmap ABS_X=x1,ABS_Y=y1,ABS_RX=x2,ABS_RY=y2,ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y, --axismap -Y1=Y1,-Y2=Y2 --evdev-keymap BTN_SOUTH=a,BTN_EAST=b,BTN_WEST=x,BTN_NORTH=y,BTN_TL=lb,BTN_TL2=lt,BTN_TR=rb,BTN_TR2=rt,BTN_SELECT=back,BTN_START=start,BTN_MODE=guide,BTN_THUMBL=tl,BTN_THUMBR=tr, --mimic-xpad

else
	echo " "
	echo "pt_BR: Ligue e pareie o controle, e então execute o script novamente."
	echo "en_US: Turn the gamepad on and paired, and run the script again."
	echo " "
fi
