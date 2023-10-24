require('bufferline').setup({
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				text = "NVIM TREE🌳",
				highlight = "Directory",
				separator = true -- use a "true" to enable the default, or set your own character
			}
		},
		buffer_close_icon = '',
	}
})

vim.keymap.set('n', 'gb', '<cmd>BufferLinePick<CR>')
