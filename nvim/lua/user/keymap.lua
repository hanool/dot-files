vim.g.mapleader = " "

-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "gt", "<cmd>bnext<CR>")
map("n", "gT", "<cmd>bprev<CR>")
map("n", "<Leader>x", "<cmd>bd<CR>")
map("n", "<C-m><C-m>", "za")

map("n", "<Leader>T", "<cmd>ToggleTerm<CR>a")

map("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
map("n", "<Leader><Leader>", ":lua vim.lsp.buf.hover()<CR>")
