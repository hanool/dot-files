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

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		requires = {
			{ 'nvim-lua/plenary.nvim' }
		}
	}

	-- Post-install/update hook with neovim command
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	-- StatusLine
	use { 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons' }

	-- UFO
	use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

	use "lukas-reineke/indent-blankline.nvim"

	-- Theme
	use({ 'rose-pine/neovim', as = 'rose-pine' })

	-- Terminal
	use { "akinsho/toggleterm.nvim", tag = '*', config = function()

	end }

	-- ========== LSP ========== --
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			-- Easy LS Install
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- LSP Support
			{ "neovim/nvim-lspconfig" },

			-- Autocompletion
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-cmdline' },
			{ 'hrsh7th/nvim-cmp' },
		}
	}

	use { 'windwp/nvim-autopairs' }

	use { 'windwp/nvim-ts-autotag' }

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
