" pathogen - supposedly the greatest thing since sliced bread
call pathogen#infect()

" set auto-indenting on for programming
set autoindent

" turn off compatibility with the old vi
set nocompatible

" stevelosh recommended settings:
set encoding=utf-8
set hidden
set wildmenu
set wildmode=list:longest
set ttyfast
set ruler
if version >=730
	set relativenumber
	set undofile
	set colorcolumn=85
endif
let mapleader = ","
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
set wrap
set textwidth=79
set formatoptions=qrn1
set list
set listchars=tab:▸\ ,eol:¬
set showbreak=…
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>v V`]
nnoremap <leader>q gqip
nnoremap <leader>ft Vatzf
nnoremap <leader>a :Ack
inoremap jj <Esc>


" set our tabs to four spaces
set tabstop=4
set shiftwidth=4

" line numbering
set number

"sane line breaks -- to turn off for individual files, run set nolbr
set lbr

" keys that wrap to the next line
set whichwrap=<,>,b

" turn syntax highlighting on by default
syntax on

" set colorscheme to slate
colorscheme slate

" automatically show matching brackets. works like it does in bbedit.
set showmatch

" do NOT put a carriage return at the end of the last line! if you are programming
" for the web the default will cause http headers to be sent. that's bad.
set binary noeol

" make that backspace key work the way it should
set backspace=indent,eol,start

" OPTIONAL
" show whitespace at end of lines
highlight WhitespaceEOL ctermbg=lightgray guibg=lightgray
match WhitespaceEOL /s+$/

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

set statusline=%=%l,%c%V\/%L\ \ %P
set laststatus=2

" incsearch searches as you type in the search term
set incsearch

filetype plugin on
"au FileType python source ~/.vim/scripts/python.vim 
"au FileType python source ~/.vim/ftplugin/python_fold.vim 
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4
autocmd BufNewFile,BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
let python_highlight_all = 1
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType sql set omnifunc=sqlcomplete#Complete

augroup filetype
autocmd BufRead *.tab set filetype=tab
augroup END
filetype plugin indent on

let snips_author='Dennis Burke'

map <leader>a :Ack
map <leader><tab> :tabnew<cr>:Scratch<cr>
let yankring_history_dir='$HOME/.vim/bundle/yankring/history'
let scratch_filename='hiya,\ buddy.txt'
map <leader>r :RainbowParenthesesToggle<cr>:RainbowParenthesesLoadBraces<cr>:RainbowParenthesesLoadSquare<cr>
