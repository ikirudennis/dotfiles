" ----------------------------------------------------------------------------
" iii. Settings for specific file types
" ----------------------------------------------------------------------------
if has("autocmd")
	" Source the gvimrc file after saving it
	autocmd! BufWritePost [\._]gvimrc source $MYGVIMRC
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
set gtl=%t\ %m gtt=%F

" ----------------------------------------------------------------------------
" 10 GUI
" ----------------------------------------------------------------------------
if has("gui_macvim")
	" transparency
	set transparency=3
	" a better font...
	set gfn=Monaco:h14
	" formatoptions j is only available in macvim
	set formatoptions+=j
else
	" Droid Sans Mono size 11
	set gfn=DejaVu_Sans_Mono:h11
endif

" hide toolbar
set guioptions-=T