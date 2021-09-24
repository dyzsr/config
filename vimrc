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
Plug 'ocaml/vim-ocaml'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'rhysd/vim-llvm'

" Tools
Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'ycm-core/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'ctrlpvim/ctrlp.vim'

" Semantic Highlighting
Plug 'jaxbot/semantic-highlight.vim'

call plug#end()

" Basics
set nocompatible
set backspace=indent,eol,start
set ignorecase incsearch autoindent ruler showcmd number
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set mouse=a
set mmp=5000
set cursorline "cursorcolumn
set hlsearch
set scrolloff=5

set encoding=utf-8

syntax on
filetype plugin on
filetype plugin indent on

colorscheme koehler

nmap <leader>a ggVG"+y<ESC>
nmap <leader>c I//<ESC>
nmap <leader>x :s/\(\s*\)\/\//\1/<ESC>
nmap <leader>3 I#<ESC>
nmap <leader>2 :s/\(\s*\)#/\1/<ESC>
nmap <leader>p :set paste<CR>
nmap <leader>np :set nopaste<CR>

nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

if has("vms")
	set nobackup
endif

if has("autocmd")
  au BufReadPost *.rkt,*.rktl set filetype=racket
  au filetype racket set lisp
  au filetype racket set autoindent
endif

" Shortcuts
func! Compile()
	exec "w"
	if &filetype == "c"
		exec "!cc -o %< % -O2 -Wall -lm"
	elseif &filetype == "cpp"
		exec "!c++ -o %< % -O2 -Wall -lm -std=c++17"
  elseif &filetype == "go"
    exec "!go build %"
  elseif &filetype == "tex"
    exec "!xelatex % && bibtex %< && xelatex % && xelatex %"
  elseif &filetype == "markdown"
    exec "!pandoc --number-sections --toc --pdf-engine=xelatex -o %<.pdf %"
	endif
endfunc

func! Run()
	if &filetype == "c"
		exec "!./%<"
	elseif &filetype == "cpp"
		exec "!./%<"
  elseif &filetype == "go"
    exec "!go run %"
	endif
endfunc

let mapleader='\'

map <F9> :call Compile()<CR>
imap <F9> <ESC>:call Compile()<CR>
map <F10> :call Run()<CR>
imap <F10> <ESC>:call Run()<CR>

map <leader><F8> :w<CR> :exec "!c++ -o %< % -O1 -std=c++14 -Wall -mavx" <CR>
imap <leader><F8> <ESC>:w <CR> :exec "!c++ -o %< % -O1 -std=c++14 -Wall -mavx" <CR>

map <F6> :w<CR>:exec "!make"<CR>
imap <F6> <ESC>:w<CR> :exec "!make"<CR>

" NERDTree
nmap <C-n> :NERDTreeToggle<CR>

" Go
" All files end with .y are detected as goyacc parser definition file.
autocmd BufNewFile,BufReadPost *.y setlocal filetype=goyacc
let g:go_fmt_command = "goimports"
nmap <leader>r :GoReferrers<CR>

function! GoBufIO()
  return
        \  "var _rbuf=bufio.NewReader(os.Stdin)\n"
        \. "var _wbuf=bufio.NewWriter(os.Stdout)\n"
        \. "func scan(a ...interface{}){_wbuf.Flush();fmt.Fscan(_rbuf,a...)}\n"
        \. "func printf(f string, a ...interface{}){fmt.Fprintf(_wbuf,f,a...)}\n"
        \. "\nfunc main() {\ndefer _wbuf.Flush()\n}\n"
endfunction

iab <expr> __IO GoBufIO()

" Rust
let g:rustfmt_autosave = 1

" OCaml
let g:opamshare = substitute(system('opam var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" Auto Complete
set completeopt-=preview

" YCM
let g:ycm_auto_hover = ''
nmap <leader>d <plug>(YCMHover)

" Tagbar
nmap <leader>t :TagbarToggle<CR>

