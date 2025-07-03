#!/bin/bash
cd ~/poky
source oe-init-build-env build-rpi32
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
bitbake core-image-minimal
