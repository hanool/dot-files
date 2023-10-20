vim.cmd('autocmd!')

vim.opt.fileencodings = { 'utf-8', 'sjis' }
vim.opt.hlsearch = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.wo.wrap = false
vim.opt.modifiable = true

vim.opt.syntax = 'on'
vim.opt.termguicolors = true

vim.opt.colorcolumn = '99'

vim.opt.modifiable = true

-- Formatting Options
vim.cmd('autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o') -- no continous comment on new line
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]] -- format on save
