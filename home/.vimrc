" Plugins
call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
call plug#end()

" Colour scheme
colorscheme nord
let g:lightline={'colorscheme':'nord'}

" Prevent bad habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Enable syntax highlighting
syntax on

" Tabs are (4) spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Auto-indent new lines
set autoindent

" Show (relative) line numbers
set number
set relativenumber

" Use comma as leader
let mapleader=","

" Highlight matching brackets etc.
set showmatch

" Highlight search results ...
set incsearch
set hlsearch
" ... and add a shortcut to turn off the highlighting
nnoremap <leader><leader> :nohlsearch<CR>

" Don't beep or flash on bell
set visualbell
set t_vb=

" Always display status line
set laststatus=2
