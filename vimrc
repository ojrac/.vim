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
Plugin 'jnurmine/Zenburn'
Plugin 'fatih/vim-go'
Plugin 'rking/ag.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-sleuth'
Plugin 'jceb/vim-orgmode'
Plugin 'elixir-lang/vim-elixir'
Plugin 'hut8labs/diffscuss', {'rtp': 'diffscuss.vim/'}
Plugin 'mileszs/ack.vim'

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
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pep8', 'pylint']
let g:syntastic_python_pylint_args = "--rcfile=pylintrc"

" Some user-defined color groups for the status line
hi User0  guifg=#dcdccc guibg=#2e3330 ctermfg=188 ctermbg=236
hi User2  guifg=#f18c96 guibg=#2e3330 gui=bold ctermfg=210 ctermbg=236 cterm=bold
hi User4  guifg=#efefaf guibg=#2e3330 ctermfg=229 ctermbg=236

" Status Line: {{{

" Status Function: {{{2
function! Status(winnum)
  let active = a:winnum == winnr()
  let bufnum = winbufnr(a:winnum)
  let stat = ''
  " this function just outputs the content colored by the
  " supplied colorgroup number, e.g. num = 2 -> User2
  " it only colors the input if the window is the currently
  " focused one
  function! Color(active, num, content)
    if a:active
      return '%' . a:num . '*' . a:content . '%*'
    else
      return a:content
    endif
  endfunction
  " this handles alternative statuslines
  let usealt = 0
  let altstat = Color(active, 4, ' ]')
  let type = getbufvar(bufnum, '&buftype')
  let name = bufname(bufnum)
  if type ==# 'help'
    let altstat .= ' ' . fnamemodify(name, ':t:r')
    let usealt = 1
  elseif name ==# '__Gundo__'
    let altstat .= ' Gundo'
    let usealt = 1
  elseif name ==# '__Gundo_Preview__'
    let altstat .= ' Gundo Preview'
    let usealt = 1
  endif
  if usealt
    let altstat .= Color(active, 4, ' [')
    return altstat
  endif
  " column
  " this might seem a bit complicated but all it amounts to is
  " a calculation to see how much padding should be used for the
  " column number, so that it lines up nicely with the line numbers
  " an expression is needed because expressions are evaluated within
  " the context of the window for which the statusline is being prepared
  " this is crucial because the line and virtcol functions otherwise
  " operate on the currently focused window
  function! Column()
    let vc = virtcol('.')
    let ruler_width = max([strlen(line('$')), (&numberwidth - 1)])
    let column_width = strlen(vc)
    let padding = ruler_width - column_width
    let column = ''
    if padding <= 0
      let column .= vc
    else
      " + 1 becuase for some reason vim eats one of the spaces
      let column .= repeat(' ', padding + 1) . vc
    endif
    return column . ' '
  endfunction
  let stat .= '%1*'
  let stat .= '%{Column()}'
  let stat .= '%*'
  " file name
  let stat .= ' %<'
  let stat .= ' %f '
  " file modified
  let modified = getbufvar(bufnum, '&modified')
  let stat .= Color(active, 2, modified ? ' +' : '')
  " read only
  let readonly = getbufvar(bufnum, '&readonly')
  let stat .= Color(active, 2, readonly ? ' ‼' : '')
  " paste
  if active && &paste
    let stat .= ' %2*' . 'P' . '%*'
  endif

  if exists("g:SyntasticLoclist")
      let syntax = g:SyntasticLoclist.current().getStatuslineFlag()
      if syntax != "" && active
        let stat .= "  " . Color(active, 2, syntax)
      endif
  endif

  " right side
  let stat .= '%='
  " git branch
" if exists('*fugitive#head')
"   let head = fugitive#head()
"   if empty(head) && exists('*fugitive#detect') && !exists('b:git_dir')
"     call fugitive#detect(getcwd())
"     let head = fugitive#head()
"   endif
" endif
" if !empty(head)
"   let stat .= Color(active, 3, ' ← ') . head . ' '
" endif
  return stat
endfunction
" }}}


function! s:RefreshStatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
  endfor
endfunction

augroup status
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatus()
augroup END


" vim-go
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)


au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap gd <Plug>(go-def)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go set tabstop=4
