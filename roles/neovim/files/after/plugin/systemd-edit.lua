vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.config/systemd/user/.#*",
	callback = function()
		vim.opt.undofile = false
	end,
})
