return {
	'nvim-treesitter/nvim-treesitter',
	build = ":TSUpdate",
	config = function()
		local configs = require('nvim-treesitter.configs')
		configs.setup({
			ensure_installed = {
				"bash", "gitcommit", "lua", "markdown", "python", "query",
				"terraform", "vim", "vimdoc", "yaml"
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
