vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('user.basic')
require('user.keymap')
require('user.plugins')
require('user.plugins_config')
require('user.lsp.mason')
require('user.lsp.config')
require('user.lsp.cmp')


local plugins = { 'lualine', 'mason', 'mason-lspconfig', 'colorizer', 'ufo' }
for _, plugin in ipairs(plugins) do
	require(plugin).setup()
end

require('rose-pine')
vim.cmd('colorscheme rose-pine')
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
