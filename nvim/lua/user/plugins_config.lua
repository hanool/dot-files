-- One Dark (Theme)
--vim.cmd("colorscheme nordfox")


-- ToggleTerm
local powershell_options = {
	shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
	shellcmdflag =
	"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
	shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
	shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
	shellquote = "",
	shellxquote = "",
}

for option, value in pairs(powershell_options) do
	vim.opt[option] = value
end

require("toggleterm").setup {
	--direction = 'vertical' | 'horizontal' | 'tab' | 'float',
	direction = 'float',
	float_opts = {
		border = 'double', -- 'single' | 'double' | 'shadow'
		width = 100,
		height = 20,
		winblend = 3,
	},
}

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set('t', '<esc>', [[<C-\><C-n> <Cmd>ToggleTerm<CR>]], opts)
	vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- UFO
local ufo = require('ufo')
local lsp = require('lspconfig')

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true
}

local language_servers = lsp.util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
	lsp[ls].setup({
		capabilities = capabilities
		-- you can add other fields for setting up lsp server in this table
	})
end

-- Customize fold text
local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = ('  %d '):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, 'MoreMsg' })
	return newVirtText
end

-- if to use filetype map
local ftMap = {
	vim = 'indent',
	python = { 'indent' },
	git = ''
}

---@param bufnr number
---@return Promise
local function customizeSelector(bufnr)
	local function handleFallbackException(err, providerName)
		if type(err) == 'string' and err:match('UfoFallbackException') then
			return require('ufo').getFolds(bufnr, providerName)
		else
			return require('promise').reject(err)
		end
	end

	return require('ufo').getFolds(bufnr, 'lsp'):catch(function(err)
		return handleFallbackException(err, 'treesitter')
	end):catch(function(err)
		return handleFallbackException(err, 'indent')
	end)
end

-- Main Setup
ufo.setup({
	open_fold_hl_timeout = 150,
	fold_virt_text_handler = handler,
	close_fold_kinds = { 'imports', 'comment' },
	preview = {
		win_config = {
			border = { '', '─', '', '', '', '─', '', '' },
			winhighlight = 'Normal:Folded',
			winblend = 0
		},
		mappings = {
			scrollU = '<C-u>',
			scrollD = '<C-d>',
			jumpTop = '[',
			jumpBot = ']'
		}
	},
	provider_selector = function(bufnr, filetype, buftype)
		return ftMap[filetype] or customizeSelector
	end
})

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
vim.keymap.set('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'K', function()
	local winid = ufo.peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end)
