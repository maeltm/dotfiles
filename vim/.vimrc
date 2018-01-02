set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

Plugin 'vimwiki/vimwiki'
Plugin 'moll/vim-node'
Plugin 'wombat256.vim'

call vundle#end()
filetype plugin indent on

syntax on
set number
set list

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set noswapfile
set nowritebackup
set nobackup

set hlsearch
set ignorecase
set smartcase

colorscheme wombat256mod

let g:vimwiki_list = [{'path': '~/workspace/GoogleDrive/notes/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_conceallevel = 0
