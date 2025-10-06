return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ansiblels",
					"bashls",
					"marksman",
					"pyright",
					"terraformls",
				},
			})
		end,
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
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config('lua_ls', {
				capabilities = capabilities,
			})
			vim.lsp.config('ansiblels', {
				capabilities = capabilities,
			})
			vim.lsp.config('bashls', {
				capabilities = capabilities,
			})
			vim.lsp.config('pyright', {
				capabilities = capabilities,
			})
			vim.lsp.config('terraformls', {
				capabilities = capabilities,
			})
			vim.lsp.config('tflint', {
				capabilities = capabilities,
			})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gg", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gl", vim.diagnostic.open_float, {})
			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>gq", vim.diagnostic.setqflist, { desc = "Add diagnostics to quickfix list" })
		end,
	},
}
