" Some Vundle plugins stuff
" set nocompatible
" filetype off

" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" Let Vundle manage Vundle
" Plugin 'gmarik/Vundle.vim'

" Load plugins
"  Easymotion plugin for fast file browsing
" Plugin 'Lokaltog/vim-easymotion'

" call vundle#end()
" filetype plugin indent on

" execute pathogen#infect()
" filetype plugin indent on

" Remap the leader key
let mapleader= "<SPACE>"

" Completion
set wildmenu
set wildmode=list:longest

" Aesthetics..
syntax enable
set background=light
" colorscheme desert
" colorscheme solarized

"set background=light
"colorscheme solarized
set guifont=Inconsolata\ 10

" Indentation
"set autoindent      " use the indent from the previous line.
set smartindent     " is like 'autoindent' but also recognizes some C syntax to
                    "     increase/reduce the indent where appropriate.
                    "     (overwrites autoindent if enabled)

set foldmethod=indent
"set foldmethod=syntax
set foldnestmax=2
set foldlevelstart=2
"let fortran_fold=1

"-----------------------------------------------------
" Some key remappings 
"-----------------------------------------------------
" ADD COMMENT HERE
nmap pw :inoremap <lt>Space> <lt>Space><lt>Esc>:iunmap <lt>lt>Space><lt>CR><CR> cw
" ADD COMMENT HERE
nmap p$ :inoremap <lt>CR> <lt>CR><lt>Esc>:iunmap <lt>lt>CR><lt>CR><CR> c$
" ADD COMMENT HERE
nmap <S-Enter> O<Esc>j
" ADD COMMENT HERE
nmap <CR> o<Esc>k

" 1. INSERT MODE REMAPPINGS
" Easily go to normal mode without exiting homerow
inoremap jj <ESC>
inoremap jk <ESC>
" Easiliy deleting in insert mode without exiting homerow (don't use this too often)
inoremap ù <DEL>

" 2. NORMAL MODE REMAPPINGS
" Instantly compile source files by typing: m, Enter
noremap m :! make 
" Easier forward search on azerty keyboard layout
"nnoremap ; /
" Remove highlighted searchterms
nnoremap , :noh<Enter>

" 3. VISUAL MODE REMAPPINGS
" Repeat action for multiple lines
vnoremap . :normal .<CR>

set noswapfile

" Line numbering
set number          " Enable
"set nonumber        " Disable

"Use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.
set smarttab        " Insert tabs on the start of a line according to
                    "     shiftwidth, not tabstop

" Line wrapping
"set wrap            " Enable line wrapping
"set linebreak       " Do not split words across two lines
"set wm=0            " Set 'wrapmargin': margin for wrapped lines
"set tw=72           " Set 'textwidth': width after which wrapping is applied
set nowrap          " Disable line wrapping

" hide hidden charachters
set nolist

set showmatch       " set show matching parenthesis
