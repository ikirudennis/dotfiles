" ----------------------------------------------------------------------------
" iii. Settings for specific file types
" ----------------------------------------------------------------------------
if has("autocmd")
	" Source the gvimrc file after saving it
	autocmd! BufWritePost ~/.config/nvim/ginit.vim source ~/.config/nvim/ginit.vim|call lightline#disable()|call lightline#enable()
endif

" ----------------------------------------------------------------------------
" 4 displaying text
" ----------------------------------------------------------------------------
" size the screen
set lines=40
set columns=120

" ----------------------------------------------------------------------------
" 7 multiple tab pages
" ----------------------------------------------------------------------------
" tab bar niceties
"set gtl=%t\ %m
"set gtt=%F

" ----------------------------------------------------------------------------
" 10 GUI
" ----------------------------------------------------------------------------
if has("gui_macvim")
	" transparency
	set transparency=1
	" a better font...
	set gfn=FuraMonoNerdFontComplete-Regular:h14
	" formatoptions j is only available in macvim
	set formatoptions+=j
elseif has("win32")
	" windows just HAS to be different, eh?
	set gfn=FuraMonoForPowerline_NF:h11:cANSI:qDRAFT
elseif exists('g:GuiLoaded')
	" nvim-qt specific
	set gfn=FiraMono\ Nerd\ Font\ Mono:h11
	" show scrollbars
	GuiScrollBar 1
	" Right Click Context Menu (Copy-Cut-Paste)
	nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
	inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
	xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
	snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
	" show buffer information in window title
	set title
	" use QT tab bar
	GuiTabline 1
else
	" fallback
	set gfn=FiraMono\ Nerd\ Font\ Mono 11
	set linespace=-2
endif

" hide toolbar
"set guioptions-=T

" ----------------------------------------------------------------------------
" 13 selecting text
" ----------------------------------------------------------------------------
set clipboard=unnamed