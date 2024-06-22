-- --------------------------------------------------------------------------
-- i. Setup
-----------------------------------------------------------------------------

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
-- "plugins" below refers to lua files in ~/.config/nvim/lua/plugins/
require("lazy").setup("plugins")

-- ----------------------------------------------------------------------------
-- ii. Shortcuts
-- ----------------------------------------------------------------------------

-- edit neovim init.lua
vim.keymap.set("n", "<leader>ev", ":tabe $MYVIMRC<cr>", { desc = "edit neovim init.lua" })
-- Select recently-pasted text
vim.keymap.set("n", "<leader>v", "V`]", { desc = "select recently-pasted text" })
-- reformat a paragraph
vim.keymap.set("n", "<leader>q", "gqip", { desc = "reformat text" })
-- jj is easier to type than escape
vim.keymap.set("i", "jj", "<Esc>", { desc = "jj works as another esc" })
-- easily turn off search highlighting with comma-space
vim.keymap.set("n", "<leader><space>", ":noh<cr>", { desc = "toggle search highlighting", silent = true })
-- in both normal and visual modes, use tab key as a synonym for % which jumps
-- to corresponding parentheses, braces and brackets
vim.keymap.set({ "n", "v" }, "<tab>", "%", { desc = "also use <tab> for %-style jumping" })

-- in both normal and visual modes, use the 'very magic' search setting.  Makes
-- search behave sanely.  See :help /magic for more info
vim.keymap.set({ "n", "v" }, "/", "/\\v", { desc = "default to very magic search" })

-- -----------------------------------------------------------------------------
-- iii. Custom commands
--------------------------------------------------------------------------------

-- define a command ':H' which will open a help file in a new tab. completion
-- will use the same arguments available to a normal `:help` command. The
-- argument is automatically added to the end of the "tab help" portion of the
-- command.
vim.api.nvim_create_user_command('H', "tab help <args>",
	{ bang=true, complete='help', nargs=1 }
)

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
-- the old zenburn had the following to allow some settings tweaks
-- - https://github.com/jnurmine/Zenburn/blob/master/colors/zenburn.vim#L246
-- - https://github.com/jnurmine/Zenburn/blob/master/colors/zenburn.vim#L479
-- 
-- the below was taken from https://stackoverflow.com/a/75113677, but doesn't
-- quite work right for the comment italic
-- - vim.api.nvim_set_hl(0, 'Comment', { italic = true })
--
-- the taghighlight thing might not be very important

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