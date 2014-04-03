#!/bin/bash

mkdir -p $HOME/.vim/bundle
if [ ! -d $HOME/.vim/bundle/vundle ]; then
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

vim +PluginInstall +qall
