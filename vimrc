" An example for a vimrc file.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"           for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
"
" Note the required backslash.
execute pathogen#infect()

" Assume we can support 256 colors
set t_Co=256
:let g:zenburn_high_Contrast=1
:colorscheme zenburn

let mapleader = "\<space>"

if v:progname =~? "evim"
  finish
endif

set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4

set timeoutlen=250

set ignorecase

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup          " do not keep a backup file, use versions instead
else
  set nobackup            " keep a backup file
endif
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")

fu! DoRunPyBuffer()
    pclose! " force preview window closed
    setlocal ft=python

    " copy the buffer into a new window, then run that buffer through python
    sil %y a | below new | sil put a | sil %!python -
    " indicate the output window as the current previewwindow
    setlocal previewwindow ro nomodifiable nomodified

    " back into the original window
    winc p
endfu

command! RunPyBuffer call DoRunPyBuffer()
map <Leader>p :RunPyBuffer<CR>

cmap WW w !sudo tee % > /dev/null

set cursorline

" Remap to also look for {}s not in the first column
:map [[ ?{w99[{
:map ][ /}b99]}
:map ]] j0[[%/{
:map [] k$][%?}

:nmap <Leader>l :setlocal number!<CR>
:nmap <Leader>o :set paste!<CR>

" More familiar movement keys
:cnoremap <C-a>  <Home>
:cnoremap <C-b>  <Left>
:cnoremap <C-f>  <Right>
:cnoremap <C-d>  <Delete>
:cnoremap <M-b>  <S-Left>
:cnoremap <M-f>  <S-Right>
:cnoremap <M-d>  <S-right><Delete>
:cnoremap <Esc>b <S-Left>
:cnoremap <Esc>f <S-Right>
:cnoremap <Esc>d <S-right><Delete>
:cnoremap <C-g>  <C-c>

" Smart searching
:set incsearch
:set ignorecase
:set smartcase
:set hlsearch
:nmap <Leader>q :nohlsearch<CR>

:nmap <Leader>w :NERDTreeToggle<CR>

" Hotkeys for switching buffers
:nmap <C-q> :e#<CR>     " Last open buffer
:nmap <C-n> :bnext<CR>
:nmap <C-p> :bprev<CR>

" Ctrl-P
:nmap <CR> :CtrlPBuffer<CR>
:nmap <Leader>e :CtrlP<CR>

let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

set wildignore=*.swp,*.pyc
set title
set nobackup
set noerrorbells

" Don't require Shift when pressing :
nnoremap ; :

vmap Q gq
nmap Q gqq

" Window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
