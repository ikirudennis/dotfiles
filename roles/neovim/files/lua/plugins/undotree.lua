return {
	dir = vim.env.VIMRUNTIME .. '/pack/dist/opt/nvim.undotree',
	name = "undotree",
	keys = {
		{ '<F5>', function() require('undotree').open() end, mode = { 'n' }, desc = "Toggle Undotree"},
	},
	config = function()
		-- The built-in package doesn't need much, but we can ensure it's loaded
	end
}
