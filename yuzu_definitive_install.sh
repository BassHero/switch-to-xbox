#!/bin/bash

firmware=Firmware\ 17.0.1.zip
keys=prod.keys
switch_icon=nintendo-switch.png
versao=EA-4176
yuzu_latest=Linux-Yuzu-$versao.AppImage

mkdir 'Nintendo Switch'
cd 'Nintendo Switch'
mkdir firmware icons key roms ryujinx

if [ -e $yuzu_latest ]; then
	echo 'Não foi preciso baixar o emulador, pois já foi baixado anteriormente.'	
else	
	echo 'Baixando o emulador, isso pode demorar um pouco, tenha paciência.'
	wget https://github.com/pineappleEA/pineapple-src/releases/download/$versao/$yuzu_latest
fi

# if [ -e Firmware\ 17.0.1.zip ]; then
#	echo 'Não foi preciso baixar a firmware, pois já foi baixada anteriormente.'
# else
#	echo 'Baixando a firmware, isso pode demorar um pouco, tenha paciência.'
#
#	wget https://archive.org/download/nintendo-switch-global-firmwares/Firmware%2017.0.1.zip	
# fi

if [ -e $keys ]; then
	echo 'Não foi preciso baixar o prod.keys, pois já foi baixado anteriormente.'
else
	echo 'Baixando o prod.keys.'
	wget https://archive.org/download/prod_20230920/prod.keys	
fi

if [ -e $switch_icon ]; then
	echo 'Não foi preciso baixar o iconedo Nitendo Switch, pois já foi baixado anteriormente.'
else
	echo 'Baixando o icone do Nitendo Switch.'
	wget https://upload.wikimedia.org/wikipedia/commons/9/9f/Nintendo-switch-icon.png
	mv Nintendo-switch-icon.png nintendo-switch.png
fi

file-roller -e firmware Firmware\ 17.0.1.zip
# rm Firmware\ 17.0.1.zip
mv prod.keys key
mkdir -p ~/.local/share/yuzu/keys
mkdir -p ~/.local/share/yuzu/nand/system/Contents
pwd=`pwd`
ln -s $pwd/firmware ~/.local/share/yuzu/nand/system/Contents/registered
cp $switch_icon ~/.local/share/icons

echo "[Desktop Entry]
Name=Nintendo Switch
Comment=Yuzu, Emulator de Nintendo Switch
Exec=./Nintendo_Switch
Icon=nintendo-switch
Terminal=false
Type=Application
Categories=Game;
" >> Nintendo_Switch.desktop

echo "#!/bin/bash
gamemoderun ./Linux-Yuzu-EA-4176.AppImage
" >> yuzu_start.sh

chmod a+x Nintendo_Switch.desktop yuzu_start.sh Linux-Yuzu-EA-4176.AppImage
cp Nintendo_Switch.desktop ~/.local/share/applications

ln -s $pwd/yuzu_start.sh ~/Nintendo_Switch	

	

