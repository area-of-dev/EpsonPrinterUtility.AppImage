# This software is a part of the A.O.D apprepo project
# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
SHELL := /usr/bin/bash
APPDIR := ./AppDir
PWD := $(shell pwd)


all: clean
	wget --output-document=build.rpm https://download3.ebz.epson.net/dsc/f/03/00/11/33/93/87615b79f97e274e65e2ec63619da9c8c19f05fb/epson-printer-utility-1.1.1-1lsb3.2.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/qt-4.8.7-8.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/qt-x11-4.8.7-8.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/libpng-1.5.13-7.el7_2.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	cp -rf opt/epson-printer-utility/* AppDir/

	mkdir -p ./AppDir/bin
	mkdir -p ./AppDir/lib
	mkdir -p ./AppDir/bin

	cp -rf usr/lib64/* AppDir/lib
	cp -rf usr/bin/* AppDir/bin

	export ARCH=x86_64 && bin/appimagetool-x86_64.AppImage  ./AppDir ./EpsonPrinterUtility.AppImage
	chmod +x ./EpsonPrinterUtility.AppImage

clean:
	rm -rf *.rpm *.deb
	rm -rf ./AppDir/bin
	rm -rf ./AppDir/doc
	rm -rf ./AppDir/resource
	rm -rf ./AppDir/rules
	rm -rf ./AppDir/lib
	rm -rf ./opt
	rm -rf ./usr
