#!/bin/bash

sudo apt-get install -y libcups2-dev libcupsimage2-dev g++ cups cups-client links2 git imagemagick

cd ~
git clone https://github.com/hmazter/raspberrypi-label-printer.git
wget http://download.dymo.com/Download%20Drivers/Linux/Download/dymo-cups-drivers-1.4.0.tar.gz
tar xvf dymo-cups-drivers-1.4.0.tar.gz
cd dymo-cups-drivers-1.4.0.5/
sudo ./configure
sudo make
sudo make install
cd ~
cd raspberrypi-label-printer
make
cd ~
echo "https://github.com/hmazter/raspberrypi-label-printer"
echo "https://www.hmazter.com/2013/05/raspberry-pi-printer-server-for-labelwriter"
echo "PageSize parameter can be found in the lw450.ppd file (/dymo-cups-drivers-1.4.0.5/ppd/lw450.ppd)"
echo "sudo usermod -a -G lpadmin pi"
echo "For a network share use links2"

