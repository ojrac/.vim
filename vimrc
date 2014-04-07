set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'


" The following are examples of different formats supported.
" Keep Plugin commands between here and filetype plugin indent on.
" scripts on GitHub repos
Plugin 'jnwhiteh/vim-golang'
Plugin 'rking/ag.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Lokaltog/powerline'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-sleuth'
Plugin 'jnurmine/Zenburn'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" scripts from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"Plugin 'FuzzyFinder'
" scripts not on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" ...

filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
" Put your stuff after this line

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

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching

set cursorline
set number

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set autoindent
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

" easymotion
map t <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['pep8', 'pylint']
let g:syntastic_python_pylint_args = "--rcfile=pylintrc"
