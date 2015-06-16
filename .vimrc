" ----------------------------------------------------------------------------
" i. Setup
" ----------------------------------------------------------------------------

source $HOME/.vim/addons.vim

" VAM is a slightly neater way of setting up vim plugins.  Vundle and the like
" make it easy to use up-to-date versions of plugins, but don't allow for
" mercurial repos.  The documentation for VAM kind of sucks, but I've at least
" got this working, and this will mean a lot fewer sub-repos.
fun! SetupVAM(addons)
  let c = get(g:, 'vim_addon_manager', {})
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
  let c.log_to_buf = 0
  let c.auto_install = 1
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    let cmd = '/usr/bin/git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
    let cmd .= shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
    call system(cmd)
  endif
  call vam#ActivateAddons(a:addons, {'auto_install' : 1})
endfun

call SetupVAM(g:my_addons)

" Oh, windows. Must you always be such a pain in the ass?
if has('win32') || has('win64')
    " Make windows use ~/.vim too, I don't want to use _vimfiles
    set runtimepath^=~/.vim
    set encoding=utf-8
endif

" use comma instead of backslash for commands
let mapleader = ","

" ----------------------------------------------------------------------------
" ii. Shortcuts
" ----------------------------------------------------------------------------
" edit .vimrc
nnoremap <leader>ev :tabe $MYVIMRC<cr>
" Select recently-pasted text
nnoremap <leader>v V`]
" reformat a paragraph
nnoremap <leader>q gqip
" jj is easier to type than escape 
inoremap jj <Esc>
" easily turn off search highlighting with comma-space
nnoremap <silent> <leader><space> :noh<cr>
" in both normal and visual modes, use tab key as a synonym for % which jumps
" to corresponding parentheses, braces and brackets
nnoremap <tab> %
vnoremap <tab> %
" in both normal and visual modes, use the 'very magic' search setting.  Makes
" search behave sanely.  See :help /magic for more info
nnoremap / /\v
vnoremap / /\v

" ----------------------------------------------------------------------------
" iii. Settings for specific file types
" ----------------------------------------------------------------------------
filetype plugin indent on
if has("autocmd")
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
	autocmd FileType c setlocal omnifunc=ccomplete#Complete
	autocmd FileType sql setlocal omnifunc=sqlcomplete#Complete

	" HTML fold tag
	au FileType html,htmldjango nnoremap <buffer> <leader>ft Vatzf

	" default settings for working with a python file.
	autocmd FileType python setlocal tabstop=4|setlocal shiftwidth=4|setlocal expandtab|setlocal softtabstop=4|setlocal foldcolumn=1|setlocal foldmethod=indent|setlocal textwidth=79
	autocmd BufNewFile,BufRead *.py setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class|let python_highlight_all = 1

	" default settings for working in javascript
	autocmd FileType javascript setlocal tabstop=2|setlocal shiftwidth=2|setlocal expandtab|setlocal softtabstop=2|setlocal foldcolumn=1|setlocal foldmethod=syntax|setlocal textwidth=79|setlocal foldlevelstart=0|let javaScript_fold=1

	" allow txt files to utilize modelines to specify local settings
	autocmd BufRead *.txt setlocal modeline|setlocal modelines=1

	" tab filetype is for guitar tabs
	autocmd BufRead *.tab setfiletype=tab

	" Upon opening a file that has previously been opened, go to the position
	" the cursor was in the last time it was opened. From :help restore-cursor
	autocmd BufReadPost *
	    \ if line("'\"") > 1 && line("'\"") <= line("$") |
	    \   exe "normal! g`\"" |
		\ endif

	" use modelines in *.vim files
	autocmd BufRead *.vim setlocal modeline|setlocal modelines=1

	" Source the vimrc file after saving it
	autocmd! BufWritePost [\._]vimrc source $MYVIMRC

endif

" ----------------------------------------------------------------------------
" iv. Plugin settings and shortcuts
" ----------------------------------------------------------------------------
" some snippets will insert the author's name
let g:snips_author='Dennis Burke'

" shortcut to Ack command
map <leader>a :Ack<space>

" quickly open a scratch document with the filename, 'hiya, buddy'
map <leader><tab> :Tscratch<cr>
let g:scratch_filename='hiya, buddy'
let g:scratch_bufclose=2

" gotta store the history somewhere
let yankring_history_dir='$HOME/.vim_run'

" Toggle rainbow parentheses
map <leader>r :RainbowParenthesesToggle<cr>:RainbowParenthesesLoadBraces<cr>:RainbowParenthesesLoadSquare<cr>

" gundo plugin shortcut
nnoremap <F5> :GundoToggle<CR>

let g:slime_send_key = '<leader>slime'
let g:slime_target = 'tmux'

" hide nerdtree-tabs by default
let g:nerdtree_tabs_open_on_gui_startup=0
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" define os-specific locations for ctags
let os = system('uname -s')
let osversion = system('uname -r')
if os == 'Darwin'
    let g:easytags_cmd = '/usr/local/bin/ctags'
else
    " if centos 6
    if matchstr(osversion, '2.6.32')
        let g:easytags_cmd = '$HOME/bin/ctags'
    endif
endif

" by default, easytags stores tags in ~/.vimtags.  This contributes to that
" file becoming exceptionally large.  This will force easytags to use a tags
" file relative to a project instead of using a global tagsfile.
let g:easytags_dynamic_files = 2

" Make SuperTab work sanely with snippets
let g:SuperTabDefaultCompletionType = "<c-x><c-u>"

" ----------------------------------------------------------------------------
" v. Custom commands
" ----------------------------------------------------------------------------
function! Helptab(search)
	" open help file related to the argument in a new tab which is the only
	" window in that tab
	exec ':tabnew +:h\ '. a:search .' | only'
endfunction
" define a command ':H' which calls the function defined above.
" completion for this command with be use arguments available to help.
command! -complete=help -nargs=1 H call Helptab(<q-args>)

" ----------------------------------------------------------------------------
" 1 important
" ----------------------------------------------------------------------------
" turn off compatibility with the old vi
set nocompatible
" toggle pastemode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" ----------------------------------------------------------------------------
" 2 moving around, searching and patterns
" ----------------------------------------------------------------------------
" when searching, ignore the case sensitivity in the search string, unless the
" case is specified.
set ignorecase
set smartcase
" keys that wrap to the next line
set whichwrap=<,>,b
" searches as you type in the search term
set incsearch

 " ----------------------------------------------------------------------------
 " 3 tags
 " ----------------------------------------------------------------------------
" Hopefully this reduces the size of the global vimtags file and contributes
" to easytags being more responsive
 set tags=./.tags;,~/.vimtags
 
" ----------------------------------------------------------------------------
" 4 displaying text
" ----------------------------------------------------------------------------
" relativenumber is a vim 7.3+ feature and can only be used in conjunction
" with number in vim 7.4+
if version >= 704
	" show relative numbers and current line number
	set relativenumber
	set number
elseif version == 703
	" line numbers are shown relative to the current line
	set relativenumber
else
	" use regular line numbers instead
	set number
endif
" wrap long lines
set wrap
" display characters to indicate non-printing characters
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
" with set wrap, this character shows that a soft line-break has occurred
set showbreak=…
" sane line breaks -- to turn off for individual files, run set nolbr
set linebreak
" set colorscheme to zenburn
colorscheme zenburn

" ----------------------------------------------------------------------------
" 5 syntax, highlighting and spelling
" ----------------------------------------------------------------------------
if has('syntax')
	if exists('+colorcolumn')
		" show a vertical indication of the column which is one character
		" beyond the textwidth setting
		set colorcolumn=+1
	endif
	" turn syntax highlighting on by default
	syntax on
endif

" highlight the text that matches the last search
" see Shortcuts below to find out how to easily turn off search highlighting
" with comma-space
set hlsearch
" show whitespace at end of lines
highlight WhitespaceEOL ctermbg=lightgray guibg=lightgray
match WhitespaceEOL /s+$/

" ----------------------------------------------------------------------------
" 6 multiple windows
" ----------------------------------------------------------------------------
" set hidden allows switching between buffers without vim complaining about
" unsaved changes
set hidden
" not exactly sure why I felt the need to add these two, however, it seems
" like a more sensible default
set splitbelow
set splitright
" always display the status line
set laststatus=2

" ----------------------------------------------------------------------------
" 8 terminal
" ----------------------------------------------------------------------------
" this is a legacy option, more or less.
set ttyfast

" ----------------------------------------------------------------------------
" 12 messages and info
" ----------------------------------------------------------------------------
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

" ----------------------------------------------------------------------------
" 14 editing text
" ----------------------------------------------------------------------------
" set default textwidth to a reasonable value
set textwidth=80
" define how to automatically format comments.  See :help fo-table for
" explanation.
set formatoptions=qcan1
" automatically show matching brackets. Works like it does in bbedit.
set showmatch
" make that backspace key work the way it should
set backspace=indent,eol,start

" ----------------------------------------------------------------------------
" 15 tabs and indenting
" ----------------------------------------------------------------------------
" set auto-indenting on for programming
set autoindent
" set our tabs to four spaces
set tabstop=4
set shiftwidth=4

" ----------------------------------------------------------------------------
" 19 reading and writing files
" ----------------------------------------------------------------------------
" update the buffer to reflect changes made to a file outside of vim.
set autoread
" do NOT put a carriage return at the end of the last line! If you are
" programming for the web the default will cause http headers to be sent.
" that's bad.
set binary noeol

" ----------------------------------------------------------------------------
" 21 command line editing
" ----------------------------------------------------------------------------
" wildmenu is the enhanced version of command completion
set wildmenu
" When more than one match, list all matches and complete till longest common
" string.
set wildmode=list:longest
" ignore files with these extensions in wildmenu
set wildignore=*.swo,*.swp,.DS_Store,*.pyc

if has("persistent_undo")
	" use an undofile
	set undofile
endif

" ----------------------------------------------------------------------------
" 25 multi-byte characters
" ----------------------------------------------------------------------------
" setting encoding allows utf-8 characters in vimrc to work.
set encoding=utf-8

" ----------------------------------------------------------------------------
" 26 various
" ----------------------------------------------------------------------------
" treat substitutions as if g is specified as the default
set gdefault