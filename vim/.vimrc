call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vimwiki/vimwiki'
Plug 'moll/vim-node'
Plug 'editorconfig/editorconfig-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'chrisbra/csv.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'posva/vim-vue'
Plug 'jremmen/vim-ripgrep'
Plug 'fcpg/vim-osc52'
Plug 'tpope/vim-surround'

"Plug 'vim-scripts/wombat256.vim'
"Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'

call plug#end()

"colorscheme wombat256mod
"colorscheme nord
set bg=dark
let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox

syntax on

set laststatus=2
set colorcolumn=80
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
set encoding=utf-8
set completeopt-=preview

autocmd BufNewFile,BufRead */.ssh/config.d/* set filetype=sshconfig

let mapleader = ","
noremap \ ,
nnoremap <esc><esc> :noh<cr><esc>

" quickfix shortcut
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" vimwiki setting
let g:vimwiki_list = [{'path': '~/workspace/notes/', 'syntax': 'markdown', 'ext': '.md'}]
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
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.go normal zR
autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd FileType go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd FileType go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd FileType go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

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
autocmd FileType go nmap <leader>gt  <Plug>(go-test)

" Ultisnips
let g:UltiSnipsExpandTrigger="<leader><tab>"

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

" ripgrep setting
nmap <leader>s :Rg 

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <C-l> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
