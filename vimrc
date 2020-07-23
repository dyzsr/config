call plug#begin('~/.vim/bundle')

" Languages
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vim-python/python-syntax'
Plug 'yaymukund/vim-haxe'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rhysd/vim-goyacc'
Plug 'rust-lang/rust.vim'
Plug 'petRUShka/vim-opencl'
Plug 'wlangstroth/vim-racket'

" Tools
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'ycm-core/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

call plug#end()

" Basics
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
"set encoding=utf-8

colorscheme koehler

if has("vms")
	set nobackup
endif

" Shortcuts
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

let mapleader='\'

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

nmap <leader>4 $
nmap <leader>1 ^
nmap <leader>a ggVG"+y<ESC>
nmap <leader>c I//<ESC>
nmap <leader>x :s/\(\s*\)\/\//\1/<ESC>
nmap <leader>3 I#<ESC>
nmap <leader>2 :s/\(\s*\)#/\1/<ESC>

nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

" Go
" All files end with .y are detected as goyacc parser definition file.
autocmd BufNewFile,BufReadPost *.y setlocal filetype=goyacc
nmap <leader>r :GoReferrers<CR>

" Rust
let g:rustfmt_autosave = 1

" Auto Complete
set completeopt-=preview

" YCM
let g:ycm_auto_hover = ''
nmap <leader>d <plug>(YCMHover)

" Tagbar
nmap <leader>t :TagbarToggle<CR>

