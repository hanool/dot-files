vim.g.mapleader = " "

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Config
map("n", "<Leader>R", ":source $MYVIMRC <CR>")
map("n", "<Leader>S", ":e $MYVIMRC <CR>")

-- ChadTree
map("n", "<Leader>v", ":CHADopen --always-focus<CR>")
map("n", "<Leader>c", ":CHADopen<CR>")

-- Barbar
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

-- Telescope
map("n", "<Leader>F", ":Telescope live_grep<CR>")

-- Yanky yank
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

-- Move Line with option+hjkl
map("n", "∆", ":m .+1<CR>==")
map("n", "˚", ":m .-2<CR>==")
map("i", "∆", "<Esc>:m .+1<CR>==gi")
map("i", "˚", "<Esc>:m .-2<CR>==gi")
map("i", "C-Enter", "<C-o>o")

map("v", "∆", ":m '>+1<CR>gv=gv")
map("v", "˚", ":m '<-2<CR>gv=gv")
