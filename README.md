.vim
====

My .vim folder. You really don't care.


Most of the stuff here is from http://statico.github.io/vim.html and http://statico.github.io/vim2.html

To override your .vimrc path, you can set an environment variable:

    export VIMINIT="so /home/USER/.vim/vimrc"

...or you can make a ~/.vimrc that looks like this:

    :so /home/USER/.vim/vimrc

...and, if you're stuck on Windows, make sure to put it in vimfiles:

    :so $HOME\vimfiles\vimrc
