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
