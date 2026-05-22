return {
	'saghen/blink.cmp',
	dependencies = {
		{
			'L3MON4D3/LuaSnip',
			version = 'v2.*',
			build = 'make install_jsregexp',
		},
		'rafamadriz/friendly-snippets',
	},
	version = '*', -- Use a release tag to download pre-built binaries
	opts = {
		keymap = {
			preset = 'default',
			['<CR>'] = { 'accept', 'fallback' },
			['<Tab>'] = { 'snippet_forward', 'fallback' },
			['<S-Tab>'] = { 'snippet_backward', 'fallback' },
			['<C-k>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' },
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'mono'
		},

		completion = {
			ghost_text = { enabled = true },
			documentation = { auto_show = true, auto_show_delay_ms = 200 },
			menu = {
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
				}
			}
		},

		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		snippets = { preset = 'luasnip' },

		signature = { enabled = true }
	},
	config = function(_, opts)
		-- Load friendly-snippets before blink setup
		require("luasnip.loaders.from_vscode").lazy_load()
		require('blink.cmp').setup(opts)
	end
}
