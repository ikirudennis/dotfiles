return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			auto_install = true,
			autotag = { enable = true },
			ensure_installed = { "diff", "gitcommit", "git_rebase", "markdown", "markdown_inline" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
	dependencies = { "gbprod/tree-sitter-gitcommit", "windwp/nvim-ts-autotag", "tadmccorkle/markdown.nvim" },
}
