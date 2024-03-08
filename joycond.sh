#!/bin/bash

# 1. Dependencies:

	sudo apt install libevdev-dev

# 2. joycond Installation:

	cd /home/$USER/Downloads
	echo "Cloning joycond repository..."
	git clone https://github.com/DanielOgorchock/joycond	
	cd joycond
	cmake .
	echo "Installing joycond..."
	sudo make install
	sudo systemctl enable --now joycond	
	#reboot

# 3. After pairing on bluetooth, press L + R simultaneously to conect as Pro Controller

