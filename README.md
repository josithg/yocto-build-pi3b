## Recommended setup : 

- **OS** : Ubuntu LTS (22.04) or Debian stable 
- **CPU** : Minimum of 6 cores and 12 threads 
- **RAM** : 
	- If DDR4 - 16 GB 
	- if DDR5 - 12 GB 
- Minimum of 50 GB free space 
- **Constant power and internet source (>5 MB/s)**

## Building steps

-  Update and Upgrade the system 
```
sudo apt update 
sudo apt upgrade -y
```

- install the necessary packages and dependencies 
```
sudo apt install gawk wget git-core diffstat unzip texinfo gcc \
     build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa \
     libsdl1.2-dev pylint xterm
```

- Clone the yocto repo  and setup the environment 
```
git clone https://git.yoctoproject.org/git/poky
cd poky
git checkout nanbield
source oe-init-build-env build-rpi
```
- clone the other essential repo in home folder 

- raspberrypi repo
```
git clone https://git.yoctoproject.org/meta-raspberrypi
cd meta-raspberrypi
git checkout nanbield 
```

- openembedded repo
```
git clone https://git.openembedded.org/meta-openembedded
cd meta-openembedded
git checkout nanbield 
```

- navigate to build-rpi folder in poky 
```
cd /home/<user>/poky/build-rpi
```

- open the bblayers.conf
```
gedit bblayers.conf
```

-  add the following lines for including Wifi , Bluetooth , SSH in your build 
```
BBLAYERS ?= " \
  /home/<user>/poky/meta \
  /home/<user>/poky/meta-poky \
  /home/<user>/poky/meta-yocto-bsp \
  /home/<user>/meta-raspberrypi \
  /home/<user>/meta-openembedded/meta-oe \
  /home/<user>/meta-openembedded/meta-python \
  /home/<user>/meta-openembedded/meta-networking \
"
```

- save and close the bblayers.conf and open local.conf
```

MACHINE ??= "raspberrypi3"

IMAGE_INSTALL:append = " \
  linux-firmware-bcm43430 \
  wpa-supplicant iw \
  bluez5 pi-bluetooth \
  dropbear \
"

IMAGE_FSTYPES += "rpi-sdimg"
ENABLE_UART = "1"
IMAGE_FSTYPES += "wic.bz2"

```

- save the file and exit and setup locale 
```
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
```

- navigate to poky folder 
```
cd /home/<user>/poky
```

- start building
```
bitbake core-image-minimal
```

- make sure you have a stable power and internet connection the build duration depends upon your cpu 

- after the build i complete navigate to 
```
/home/<user>/poky/build-rpi/tmp-glibc/deploy/images
```
to find your image 

-  decompress the image 
```
bunzip2 -f core-image-minimal-raspberrypi3.rootfs-<timestamp>.wic.bz2

```

- flash the image 
```
sudo dd if=core-image-minimal-raspberrypi3.rootfs-20250703021413.wic of=/dev/sdX bs=4M status=progress conv=fsync

```
