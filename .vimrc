" pathogen - the greatest thing since sliced bread

" allow disabling of individual plugins
let g:pathogen_disabled = []

" to disable plugin, insert the plugin's name into the second argument of the
" following line:
"call add(g:pathogen_disabled, '')

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
set wildignore=*.swo,*.swp,.DS_Store,*.pyc
set ttyfast
if version >=703
	set relativenumber
	set undofile
	set colorcolumn=+1
else
	set number
endif
let mapleader = ","
set ignorecase
set smartcase
set gdefault
set hlsearch
set wrap
set textwidth=80
" format comments with gq-commands -q, continue comment on return -r, recognize
" numbered lists -n, don't break a line after a one-letter word -1.
set formatoptions=qrn1
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set showbreak=…
set splitbelow
set splitright
set autoread

" Shortcuts
" edit .vimrc
nnoremap <leader>ev :tabe $MYVIMRC<cr>
" Select recently-pasted text
nnoremap <leader>v V`]
" reformat a paragraph
nnoremap <leader>q gqip
nnoremap <leader>a :Ack
inoremap jj <Esc>
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
nnoremap / /\v
vnoremap / /\v

" set our tabs to four spaces
set tabstop=4
set shiftwidth=4

" sane line breaks -- to turn off for individual files, run set nolbr
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

" show whitespace at end of lines
highlight WhitespaceEOL ctermbg=lightgray guibg=lightgray
match WhitespaceEOL /s+$/

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" define the display of the ruler.
" NOTES:
" 	- %25 sets the width of the ruler format area to 25 characters.  Seems
" 	  like a high enough number.  That allows me to see information on
" 	  insane files, i.e.: 826,1619-2983/ 827 Bot
" 	- it needs those parentheses immediately after to work right.
" 	- A good way of testing these settings is to use the :sandbox command.
" 	  A la :san[dbox] :set rulerform...
set ruler
set rulerformat=%25(%=%l,%c%<%V\/\ %L\ %P%)
set laststatus=2

" incsearch searches as you type in the search term
set incsearch

filetype plugin indent on
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType sql set omnifunc=sqlcomplete#Complete
" HTML fold tag
au FileType html,htmldjango nnoremap <buffer> <leader>ft Vatzf

autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4|setlocal foldcolumn=1|setlocal foldmethod=indent
autocmd BufNewFile,BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
let python_highlight_all = 1

autocmd BufRead *.txt setlocal modeline|setlocal modelines=1

autocmd BufRead *.tab setfiletype=tab

let snips_author='Dennis Burke'

map <leader>a :Ack

map <leader><tab> :Tscratch<cr>
let g:scratch_filename='hiya, buddy'
let g:scratch_bufclose=2

let yankring_history_dir='$HOME/.vim/bundle/YankRing.vim/history'

map <leader>r :RainbowParenthesesToggle<cr>:RainbowParenthesesLoadBraces<cr>:RainbowParenthesesLoadSquare<cr>

" vim_django commands - dt seemed like it was already mapped to a yankring
" function.  Will investigate further to suss this out.
map <Leader>djt :VimDjangoCommandTTemplate<CR>
map <Leader>dja :VimDjangoCommandTApp<CR>

" toggle pastemode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" gundo plugin shortcut
nnoremap <F5> :GundoToggle<CR>

" set command-t to open files in new tab when I hit enter
let g:CommandTAcceptSelectionMap='<C-CR>'
let g:CommandTAcceptSelectionTabMap='<CR>'
let g:CommandTAcceptSelectionSplitMap='<C-s>'
let g:CommandTScanDotDirectories=1

let g:slime_send_key = '<leader>slime'

function! Helptab(search)
	" open help file related to the argument in a new tab which is the only
	" window in that tab
	exec ':tabnew +:h\ '. a:search .' | only'
endfunction

command -complete=help -nargs=1 H call Helptab(<q-args>)
