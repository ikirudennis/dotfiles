vim.keymap.set({"n", "v"}, "<leader><Tab>", "<cmd>Scratch<cr>")

return {
	"LintaoAmons/scratch.nvim",
	event = "VeryLazy",
	config = function ()
		require("scratch").setup({
			window_cmd = "edit",
			use_telescope = true,
			filetypes = {"txt", "md", "py", "js", "sh", "lua"},
		})
	end
}
