-- start treesitter upon loading a markdown file
vim.treesitter.start()

-- don't fight the autoformat settings
vim.opt_local.formatoptions:remove({ "a" })

-- Enable spell check
vim.opt_local.spell = true

-- Enable dictionary autocomplete
vim.opt_local.complete:append({ "kspell" })