vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
	local api = require 'nvim-tree.api'

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set('n', '<Leader>V', '<C-w>l')
end

require('nvim-tree').setup({
	on_attach = my_on_attach,
	filters = {
		git_ignored = false,
	}
})

vim.keymap.set("n", "<Leader>c", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<Leader>v", "<cmd>NvimTreeFocus<CR>")
