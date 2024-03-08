#!/bin/bash

# 1. dkms-hid-nintendo Installation (only if necessary):

	cd /home/$USER/Downloads
	echo "Cloning dkms-hid-nintendo's repository..."
	git clone https://github.com/nicman23/dkms-hid-nintendo
	cd dkms-hid-nintendo
	sudo dkms add .
	sudo dkms build nintendo -v 3.2
	echo "Installing dkms-hid-nintendo..."
	sudo dkms install nintendo -v 3.2
	reboot
