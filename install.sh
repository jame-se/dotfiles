#!/bin/sh

TMPDIR="/tmp/dotfiles"

git clone git@github.com:j-e-d-w-a-r-d-s/dotfiles.git $TMPDIR

install -o `whoami` -g `id -gn` -m 0600 $TMPDIR/.cshrc ~/.cshrc
install -o `whoami` -g `id -gn` -m 0600 $TMPDIR/.logout ~/.logout
install -o `whoami` -g `id -gn` -m 0600 $TMPDIR/.vimrc ~/.vimrc
install -o `whoami` -g `id -gn` -m 0600 $TMPDIR/.muttrc ~/.muttrc
install -o `whoami` -g `id -gn` -m 0600 $TMPDIR/.screenrc ~/.screenrc

rm -rf /tmp/dotfiles
