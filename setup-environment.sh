#!/bin/bash
sudo apt update && upgrade -y 
sudo apt install gawk wget git-core diffstat unzip texinfo gcc \
     build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa \
     libsdl1.2-dev pylint xterm
cd ~
git clone https://git.yoctoproject.org/git/poky
cd poky
git checkout nanbield
cd ~
git clone https://git.yoctoproject.org/meta-raspberrypi
cd meta-raspberrypi
git checkout nanbield 
cd ~
git clone https://git.openembedded.org/meta-openembedded
cd meta-openembedded
git checkout nanbield 
cd ~/poky
source oe-init-build-env build-rpi32

