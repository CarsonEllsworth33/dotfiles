#!/bin/bash

DOTFILES=$HOME/dotfiles
ln -s $DOTFILES/.zshrc $HOME/.zshrc               # install symlink to .zshrc file
ln -s $DOTFILES/.lem $HOME/.lem                   # install symlink to lem directory
ln -s $DOTFILES/.config/hypr $HOME/.config/hypr   # install symlink to hypr directory
