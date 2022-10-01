local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Packer Loading
return require('packer').startup(function(use)
  -- Packer can manage itself
	use 'wbthomason/packer.nvim'
  use "nvim-lua/plenary.nvim"
  use 'kyazdani42/nvim-web-devicons'

  -- ColorSchemes
  use "EdenEast/nightfox.nvim"

  -- StatusLine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- TabLine
  use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- File Tree Viewer
  use {
    "ms-jpq/chadtree",
    branch = "chad",
    run = "python3 -m chadtree deps"
  }

  -- CheatSheet Command
	use {
		'sudormrfbin/cheatsheet.nvim',

		requires = {
			{'nvim-telescope/telescope.nvim'},
			{'nvim-lua/popup.nvim'},
			{'nvim-lua/plenary.nvim'},
		}
	}

  -- == LISP SETTING == --

  -- Null-ls
  use { 
    "jose-elias-alvarez/null-ls.nvim", 
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require('null-ls').setup()
    end
  }

  -- DAP (Shell)
  use 'mfussenegger/nvim-dap'

  -- LSP Config
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  --use_rocks 'jsregexp'
  use {
    'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  }
  use { 'L3MON4D3/LuaSnip', tag = "v<CurrentMajor>.*"} -- Snippets plugin

  use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
  }

  -- ColorHighlighter
  use 'norcalli/nvim-colorizer.lua'

  -- TreeSitter
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }

  -- Auto Pairing
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end
}

  -- MarkDown
	use { 
		"iamcco/markdown-preview.nvim", 
		run = "cd app && npm install", 
		setup = function() vim.g.mkdp_filetypes = { "markdown" } end, 
		ft = { "markdown" }, 
	}

  -- HTML
  use 'mattn/emmet-vim'

  -- Neorg
  use {
    "nvim-neorg/neorg",
    config = function()
        require('neorg').setup {
            -- check out setup part...
        }
    end,
    requires = "nvim-lua/plenary.nvim"
  }
end)
