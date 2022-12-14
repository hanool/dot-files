vim.cmd('let $LANG="en"')
vim.cmd('autocmd!')

vim.opt.termguicolors = true
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.cursorline = true

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- Formatting Options
vim.cmd('autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o') -- no continous comment on new line
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]] -- format on save

-- Netrw(File Explorer)
-- When browsing, <cr> will open the file by
-- 0: re-using the same window (default),
-- 1: horizontally splitting the window first,
-- 2: vertically splitting the window first,
-- 3: open file in a new tab,
-- 4: act like āPā (i.e. open the previous window).
vim.g.netrw_browse_split = 3

-- Setup Plugins
vim.cmd('colorscheme duskfox')
vim.cmd('autocmd VimEnter * CHADopen --nofocus') -- open CHADTree on start up

local plugins = { 'lualine', 'mason', 'mason-lspconfig', 'colorizer' }
for _, plugin in ipairs(plugins) do
  require(plugin).setup()
end
