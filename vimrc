call plug#begin('~/.vim/bundle')

Plug 'scrooloose/nerdtree'
"Plug 'bfrg/vim-cpp-modern'
"Plug 'wizicer/vim-jison'
Plug 'pangloss/vim-javascript'
"Plug 'mxw/vim-jsx'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vim-python/python-syntax'
Plug 'yaymukund/vim-haxe'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rhysd/vim-goyacc'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'ycm-core/YouCompleteMe'
Plug 'wlangstroth/vim-racket'

call plug#end()

" Basic settings
set nocompatible
set backspace=indent,eol,start
set ignorecase incsearch autoindent ruler showcmd number
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set mouse=a
set mmp=5000
set cursorline cursorcolumn

syntax on
filetype plugin on
filetype plugin indent on

colorscheme koehler

if has("vms")
	set nobackup
endif

"set encoding=utf-8

func! Compile()
	exec "w"
	if &filetype == "c"
		exec "!cc -o %< % -O2 -Wall -lm"
	elseif &filetype == "cpp"
		exec "!c++ -o %< % -O2 -Wall -lm -std=c++17"
	endif
endfunc

func! Run()
	if &filetype == "c"
		exec "!./%<"
	elseif &filetype == "cpp"
		exec "!./%<"
	endif
endfunc

func! CompileAndRun()
	exec "w"
	if &filetype == "c"
		exec "!cc -o %< % -O2 -Wall && ./%<"
	elseif &filetype == "cpp"
		exec "!c++ -o %< % -O2 -std=c++17 -Wall && ./%<"
	endif
endfunc

let mapleader='-'

map <F9> :call Compile()<CR>
imap <F9> <ESC>:call Compile()<CR>
map <F10> :call Run()<CR>
imap <F10> <ESC>:call Run()<CR>
map <F11> :call CompileAndRun()<CR>
imap <F11> <ESC>:call CompileAndRun()<CR>

map <leader><F8> :w<CR> :exec "!c++ -o %< % -O1 -std=c++14 -Wall -mavx" <CR>
imap <leader><F8> <ESC>:w <CR> :exec "!c++ -o %< % -O1 -std=c++14 -Wall -mavx" <CR>

map <F6> :w<CR>:exec "!make"<CR>
imap <F6> <ESC>:w<CR> :exec "!make"<CR>

noremap <leader>4 $
noremap <leader>1 ^
noremap <leader>a ggVG"+y<ESC>
"noremap <leader>d :cd %:p:h<CR>
noremap <leader>c I//<ESC>
noremap <leader>x :s/\(\s*\)\/\//\1/<ESC>
noremap <leader>3 I#<ESC>
noremap <leader>2 :s/\(\s*\)#/\1/<ESC>

map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" Settings for vim-go
" All files end with .y are detected as goyacc parser definition file.
autocmd BufNewFile,BufReadPost *.y setlocal filetype=goyacc
map <leader>r :GoReferrers<CR>

" Settings for YCM
let g:ycm_auto_hover = ''
nmap <leader>d <plug>(YCMHover)

