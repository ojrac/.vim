.vim
====

My .vim folder. You really don't care.


Most of the stuff here is from http://statico.github.io/vim.html and http://statico.github.io/vim2.html

To override your .vimrc path, you can set an environment variable:

    export VIMINIT="so $HOME/.vim/vimrc"

...or you can make a ~/.vimrc that looks like this:

    :so $HOME/.vim/vimrc

...and, if you're stuck on Windows, make sure to put it in vimfiles:

    :so $HOME\vimfiles\vimrc


To compile vim from source:

    mkdir -p ~/src
    cd ~/src
    git clone https://github.com/vim/vim.git
    cd ~/src/vim
    ./configure --with-features=huge --enable-multibyte --enable-pythoninterp --enable-cscope
    make
    sudo make install
