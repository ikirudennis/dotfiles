vim.keymap.set({"n", "v"}, "<leader><Tab>", "<cmd>Scratch<cr>")

return {
	"LintaoAmons/scratch.nvim",
	event = "VeryLazy",
	config = function ()
		require("scratch").setup({
			filetypes = {"txt", "md", "py", "js", "sh", "lua"},
		})
	end
}
