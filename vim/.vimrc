set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'vim-airline/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-scripts/wombat256.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'vimwiki/vimwiki'
Plugin 'moll/vim-node'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()            " required
filetype plugin indent on    " required

colorscheme wombat256mod
syntax on

set laststatus=2
set number
set list
set noimd

set splitbelow
set splitright

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

set autowrite

let mapleader = ","
noremap \ ,
nnoremap <esc> :noh<cr><esc>

" quickfix shortcut
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" vimwiki setting
let g:vimwiki_list = [{'path': '~/workspace/GoogleDrive/notes/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_conceallevel = 0
nmap <Leader>lt <Plug>VimwikiToggleListItem
vmap <Leader>lt <Plug>VimwikiToggleListItem

" vim-go setting
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_excludes = ["should have comment or be unexported"]
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>gr  <Plug>(go-run)

" nerdTree setting
let g:NERDTreeQuitOnOpen=0
let NERDTreeShowHidden = 1
nmap <silent> <leader>k :NERDTreeToggle<cr>
nmap <silent> <leader>y :NERDTreeFind<cr>

" ctrlp setting
nmap <silent> <leader>r :CtrlPBuffer<cr>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_map = '<leader>t'
let g:ctrlp_dotfiles = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['package.json']
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](\.git|node_modules|\.hg|\.svn)$',
    \ 'file': '\.exe$\|\.so$'
    \ }
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
        \ 2: ['package.json', 'find . -type f -not \( -path "*/node_modules/*" -o -path "*/.idea/*" \)'],
    \ },
    \ 'fallback': 'find %s -type f',
    \ 'ignore': 1
    \}
let g:ctrlp_working_path_mode = 2

" syntastic js setting
let g:syntastic_javascript_checkers = ['eslint']
if executable('node_modules/.bin/eslint')
    let g:syntastic_javascript_eslint_exec ='node_modules/.bin/eslint'
endif
set statusline+=%#warningmsg#
set statusline+=%{SyntasticsStatusLineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" editorconfig setting
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
