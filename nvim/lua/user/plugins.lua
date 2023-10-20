local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	-- 'THE' packer
	use 'wbthomason/packer.nvim'

	-- Post-install/update hook with neovim command
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	-- StatusLine
	use 'nvim-tree/nvim-web-devicons'
	--use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	-- TabLine
	use {
		'romgrk/barbar.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' }
	}

	-- UFO
	use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

	use "lukas-reineke/indent-blankline.nvim"

	-- Theme
	use "EdenEast/nightfox.nvim"
	use 'navarasu/onedark.nvim'
	use({ 'rose-pine/neovim', as = 'rose-pine' })

	-- ColorHighlighter
	use 'norcalli/nvim-colorizer.lua'

	-- TreeViewer
	use "preservim/nerdtree"

	-- Markdown Previewer
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = { "markdown" },
	})

	-- Terminal
	use { "akinsho/toggleterm.nvim", tag = '*', config = function()

	end }

	-- ========== LSP ========== --
	-- Eeeeasy
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}

	-- cmp
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	use {
		'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
	}
	use { 'L3MON4D3/LuaSnip' } -- Snippets plugin

	-- Rust
	use 'simrat39/rust-tools.nvim'

	-- Emmet
	use 'mattn/emmet-vim'

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
