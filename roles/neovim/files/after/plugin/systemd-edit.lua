vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	-- worth noting: the pattern is different from how I used to define it in
	-- vimscript. not sure why it is, but the below works.
	pattern = "*/.config/systemd/user/.#*",
	callback = function()
		vim.opt.undofile = false
	end,
})
