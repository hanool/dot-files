vim.cmd('let $LANG="en"')
vim.cmd('autocmd!')

vim.cmd('colorscheme duskfox')
vim.cmd('autocmd VimEnter * CHADopen')      -- open CHADTree on start up

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

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]

-- Netrw(File Explorer)
  -- When browsing, <cr> will open the file by 
  -- 0: re-using the same window (default), 
  -- 1: horizontally splitting the window first, 
  -- 2: vertically splitting the window first, 
  -- 3: open file in a new tab, 
  -- 4: act like “P” (i.e. open the previous window).
vim.g.netrw_browse_split = 3
