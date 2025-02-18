#!/bin/bash

DOTFILES=$HOME/dotfiles
ensure_link () {
	if [ -e $1 ]; then
		# file exists
		echo "Old links deleted"
		rm $HOME/$1 # delete if it exists
	fi
	ln -s $DOTFILES/$1 $HOME/$1
}

ensure_link .zshrc        # install symlink to .zshrc file
ensure_link .lem          # install symlink to lem directory
ensure_link .config/hypr  # install symlink to hypr directory
