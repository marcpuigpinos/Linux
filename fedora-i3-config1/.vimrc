" Set tabs to be spaces
set expandtab

" Set indentation width to 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Enable automatic indentation
set smartindent
set autoindent
set smarttab

" Enable syntax highlighting
syntax enable

" Display line numbers
set number

" Set relative line numbering
set relativenumber

" Enable mouse suport
set mouse=a

" Change Shell
set shell=/usr/bin/fish

" Map Esc to switch to Normal mode in :terminal
tnoremap <Esc><Esc> <C-\><C-n>

" Clipboard
vnoremap <C-c> "+y
nnoremap <C-c> "+p
