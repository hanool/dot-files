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

vim.opt.shell = os.getenv('SHELL')

-- Formatting Options
-- no continous comment on new line
vim.cmd('autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o')
-- format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- PackerCompile on save plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Looks
require('rose-pine')
vim.cmd('colorscheme rose-pine')
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
