return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			auto_install = true,
			ensure_installed = { "diff", "gitcommit", "git_rebase" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
	dependencies = { "gbprod/tree-sitter-gitcommit" },
}
