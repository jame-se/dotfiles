#!/bin/sh

install -o `whoami` -g `id -gn` -m 0600 cshrc ~/.cshrc
install -o `whoami` -g `id -gn` -m 0600 logout ~/.logout
install -o `whoami` -g `id -gn` -m 0600 vimrc ~/.vimrc
install -o `whoami` -g `id -gn` -m 0600 muttrc ~/.muttrc
install -o `whoami` -g `id -gn` -m 0600 screenrc ~/.screenrc
