local lsp = require("lspconfig")

lsp.lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
		},
	},
}
lsp.rust_analyzer.setup {}
lsp.marksman.setup {}
lsp.tsserver.setup {}
lsp.dockerls.setup {}
lsp.powershell_es.setup {}
