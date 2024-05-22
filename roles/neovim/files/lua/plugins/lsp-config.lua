return {
	{
		"williamboman/mason.nvim",
		config = function ()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function ()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", "ansiblels", "bashls", "pyright", "terraformls",
				}
			})
		end
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black",
					"debugpy",
					"flake8",
					"isort",
					"mypy",
					"pylint",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function ()
			local lspconfig = require("lspconfig")
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			lspconfig.lua_ls.setup({
				capabilities = capabilities
			})
			lspconfig.ansiblels.setup({
				capabilities = capabilities
			})
			lspconfig.bashls.setup({
				capabilities = capabilities
			})
			lspconfig.pyright.setup({
				capabilities = capabilities
			})
			lspconfig.terraformls.setup({
				capabilities = capabilities
			})
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
			vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})

			-- on hovering for more than 250 msec, show a floating display of
			-- the diagnostic information
			vim.o.updatetime = 250
			vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
				group = vim.api.nvim_create_augroup("float_diagnostic", {clear = true}),
				callback = function ()
					vim.diagnostic.open_float(nil, {focus=false})
				end
			})
		end
	},
}
