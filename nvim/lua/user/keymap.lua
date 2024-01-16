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
map("n", "sd", ":lua vim.lsp.buf.hover()<CR>")

vim.diagnostic.config({ virtual_text = false })

local function on_hover()
	if #vim.diagnostic.get(0) > 0 then
		if vim.lsp.buf.server_ready() then
			vim.diagnostic.open_float()
		end
	else
		vim.lsp.buf.hover()
	end
end

vim.keymap.set("n", "<Leader><Leader>", on_hover, opt)
