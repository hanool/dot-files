vim.g.mapleader = " "

-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "gt", "<cmd>BufferNext<CR>")
map("n", "gT", "<cmd>BufferPrevious<CR>")
map("n", "g1", "<cmd>BufferGoto2<CR>")
map("n", "g2", "<cmd>BufferGoto3<CR>")
map("n", "g3", "<cmd>BufferGoto4<CR>")
map("n", "g4", "<cmd>BufferGoto5<CR>")
map("n", "g5", "<cmd>BufferGoto6<CR>")
map("n", "g6", "<cmd>BufferGoto7<CR>")
map("n", "g7", "<cmd>BufferGoto8<CR>")
map("n", "g8", "<cmd>BufferGoto9<CR>")
map("n", "g9", "<cmd>BufferGoto0<CR>")
map("n", "<Leader>x", "<cmd>BufferClose<CR>")
map("n", "<C-m><C-m>", "za")

map("n", "<Leader>T", "<cmd>ToggleTerm<CR>a")

map("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
map("n", "<Leader><Leader>", ":lua vim.lsp.buf.hover()<CR>")
