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
					"gopls",
					"marksman",
					"pyright",
					"stylua",
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
					"ansible-lint",
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
			-- Set default capabilities for all servers
			vim.lsp.config("*", {
				capabilities = require('blink.cmp').get_lsp_capabilities(),
			})

			-- Enable servers (configs are in ~/.config/nvim/lsp/)
			local servers = {
				"lua_ls",
				"ansiblels",
				"bashls",
				"gopls",
				"marksman",
				"pyright",
				"terraformls",
				"tflint",
			}

			for _, server in ipairs(servers) do
				vim.lsp.enable(server)
			end

			-- LSP Keymaps (only when an LSP attaches)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "<leader>gg", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>gl", vim.diagnostic.open_float, opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set(
						"n",
						"<leader>gq",
						vim.diagnostic.setqflist,
						{ buffer = ev.buf, desc = "Add diagnostics to quickfix list" }
					)
				end,
			})
		end,
	},
}
