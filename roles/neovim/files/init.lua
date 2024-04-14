-- -------------------------------------------------------------------------
-- i. Setup
----------------------------------------------------------------------------

-- use comma instead of backslash for commands. mapleader needs to be set early
-- in this file so that later commands may use it.
vim.g.mapleader = ","

-- lazy.nvim setup. addons will be stored locally in ~/.local/share/nvim/lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- "plugins" below refers to ~/.config/nvim/lua/plugins.lua
require("lazy").setup("plugins")

-- -----------------------------------------------------------------------------
-- v. Custom commands
--------------------------------------------------------------------------------

-- define a command ':H' which will open a help file in a new tab. completion
-- will use the same arguments available to a normal `:help` command. The
-- argument is automatically added to the end of the "tab help" portion of the
-- command.
vim.api.nvim_create_user_command('H', "tab help",
	{ bang=true, complete='help', nargs=1 }
)

vim.cmd [[

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
	autocmd! BufWritePost $MYVIMRC source $MYVIMRC|call lightline#disable()|call lightline#enable()

	" don't let auto-format options clobber crontab files
	autocmd FileType crontab setlocal formatoptions-=a

	" yaml defaults
	autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

endif

" ----------------------------------------------------------------------------
" iv. Plugin settings and shortcuts
" ----------------------------------------------------------------------------
" some snippets will insert the author's name
let g:snips_author='Dennis Burke'

" shortcut to Ack command
map <leader>a :Ack<space>

" quickly open a scratch document with the filename, 'hiya, buddy'
map <leader><tab> :Scratch<cr>
let g:scratch_filename='hiya, buddy'
let g:scratch_bufclose=2

" gotta store the history somewhere
let yankring_history_dir='$HOME/.cache/nvim'

" Toggle rainbow parentheses
map <leader>r :RainbowParenthesesToggle<cr>:RainbowParenthesesLoadBraces<cr>:RainbowParenthesesLoadSquare<cr>

" gundo plugin shortcut
nnoremap <F5> :GundoToggle<CR>

let g:slime_send_key = '<leader>slime'
let g:slime_target = 'tmux'

" hide nerdtree-tabs by default
let g:nerdtree_tabs_open_on_gui_startup=0
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" by default, easytags stores tags in ~/.vimtags.  This contributes to that
" file becoming exceptionally large.  This will force easytags to use a tags
" file relative to a project instead of using a global tagsfile.
let g:easytags_dynamic_files = 2

" bind ctrlp to <Leader>p
let g:ctrlp_map = '<Leader>p'
" make ctrlp show hidden files
let g:ctrlp_show_hidden = 1

" gundo was being wonky with regard to python 2 and 3. prefer py3k if available
if has('python3')
	let g:gundo_prefer_python3 = 1
endif

" lightline configuration
let g:lightline = {
	\ 'colorscheme': 'Tomorrow_Night',
	\ 'active': {
	\   'left':  [ [ 'mode', 'paste' ],
	\            [ 'readonly', 'filename', 'modified' ],
	\            [ 'bufnum' ] ],
	\   'right': [ [ 'lineinfo', 'numlines'],
	\            [ 'percent'] , [ 'virtualenv', 'filetype' ] ]
	\ },
	\ 'component': {
	\   'readonly': '%{&readonly?"\ue0a2":""}',
	\   'modified': '%{&filetype=="help"?"[HELP]":&modified?"+":&modifiable?"":"-"}',
	\   'numlines': "\ue0a1 %L"
	\ },
	\ 'component_function': {
	\   'filetype': 'LightlineFiletype',
	\   'fileformat': 'LightlineFileformat',
	\   'virtualenv': 'LightlineVirtualenv', 
	\ },
	\ 'component_visible_condition': {
	\   'readonly': '(&filetype!="help"&& &readonly)',
	\   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
	\ },
	\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
	\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
\ }

function! LightlineFiletype()
  let l:llft_string = ''
  if winwidth(0) < 70
    return l:llft_string
  endif
  if strlen(&filetype)
    let l:llft_string = &filetype . ' ' . WebDevIconsGetFileTypeSymbol()
  else
    let l:llft_string = "\uf15c"
  endif
  return l:llft_string
endfunction

function! LightlineVirtualenv()
  if strlen(virtualenv#statusline())
    return virtualenv#statusline() . " \u24d4 "
  endif
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:zenburn_italic_Comment=1
let g:zenburn_enable_TagHighlight=1

let g:snipMate = { 'snippet_version' : 1 }

]]
local set = vim.opt


----------------------------------------------------------------------------
-- 1 important
----------------------------------------------------------------------------

-- toggle pastemode
vim.api.nvim_set_keymap('n', '<F2>', '<cmd>set paste!<CR>', {
	noremap = true, silent = true })

----------------------------------------------------------------------------
-- 2 moving around, searching and patterns
----------------------------------------------------------------------------

-- when searching, ignore the case sensitivity in the search string, unless the
-- case is specified.
set.ignorecase = true
set.smartcase = true
-- keys that wrap to the next line
set.whichwrap = "<,>,b"

----------------------------------------------------------------------------
-- 3 tags
----------------------------------------------------------------------------

-- Hopefully this reduces the size of the global vimtags file and contributes
-- to easytags being more responsive
set.tags = "./.tags;,~/.vimtags"
 
----------------------------------------------------------------------------
-- 4 displaying text
----------------------------------------------------------------------------

-- show relative numbers and current line number
set.relativenumber = true
set.number = true
-- wrap long lines
set.wrap = true
-- display characters to indicate non-printing characters
set.list = true
set.listchars='tab:▸ ,eol:¬,extends:❯,precedes:❮'
-- with set wrap, this character shows that a soft line-break has occurred
set.showbreak='…'
-- sane line breaks -- to turn off for individual files, run set nolbr
set.linebreak = true
-- set colorscheme to zenburn
vim.cmd 'colorscheme zenburn'

----------------------------------------------------------------------------
-- 5 syntax, highlighting and spelling
----------------------------------------------------------------------------

-- show a vertical indication of the column which is one character beyond the
-- textwidth setting
set.colorcolumn = "+1"

-- highlight the text that matches the last search
-- see Shortcuts below to find out how to easily turn off search highlighting
-- with comma-space
set.hlsearch = true
-- show whitespace at end of lines
vim.api.nvim_set_hl(0, 'WhitespaceEOL', { ctermbg=lightgray, guibg=lightgray })
vim.cmd [[ match WhitespaceEOL /s+$/ ]]

----------------------------------------------------------------------------
-- 6 multiple windows
----------------------------------------------------------------------------

-- when splitting a window horizontally, put the new one below the current
set.splitbelow = true
-- when splitting a window vertically, put the new one to the right of the
-- current
set.splitright = true

----------------------------------------------------------------------------
-- 10 messages and info
----------------------------------------------------------------------------

-- define the display of the ruler.
-- NOTES:
-- - %25 sets the width of the ruler format area to 25 characters.  Seems
--   like a high enough number.  That allows me to see information on
--   insane files, i.e.: 826,1619-2983/ 827 Bot
-- - it needs those parentheses immediately after to work right.
-- - A good way of testing these settings is to use the :sandbox command.
--   A la :san[dbox] :set rulerform...
set.rulerformat ="%25(%=%l,%c%<%V/ %L %P%)"
-- When to not ring a bell: never
set.belloff = ''

----------------------------------------------------------------------------
-- 12 editing text
----------------------------------------------------------------------------

-- set default textwidth to a reasonable value
set.textwidth = 80
-- define how to automatically format comments.  See :help fo-table for
-- explanation.
set.formatoptions = "qcan1"
-- automatically show matching brackets. Works like it does in bbedit.
set.showmatch = true
-- use an undofile
set.undofile = true

----------------------------------------------------------------------------
-- 13 tabs and indenting
----------------------------------------------------------------------------

-- set our tabs to four spaces
local tabwidth = 4
set.tabstop = tabwidth
set.shiftwidth = tabwidth

----------------------------------------------------------------------------
-- 17 reading and writing files
----------------------------------------------------------------------------

-- do NOT put a carriage return at the end of the last line! If you are
-- programming for the web the default will cause http headers to be sent.
-- that's bad.
set.binary = true
set.eol = false

----------------------------------------------------------------------------
-- 19 command line editing
----------------------------------------------------------------------------

-- When more than one match, list all matches and complete till longest common
-- string.
set.wildmode='list:longest'
-- ignore files with these extensions in wildmenu
set.wildignore="*.swo,*.swp,.DS_Store,*.pyc"

----------------------------------------------------------------------------
-- 24 various
----------------------------------------------------------------------------

-- treat substitutions as if g is specified as the default
set.gdefault = true