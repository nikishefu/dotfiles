return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use "rebelot/kanagawa.nvim"

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons',
      },
    }

    use {
      "loctvl842/monokai-pro.nvim",
      config = function()
        require("monokai-pro").setup()
      end
    }


	use {
	  'nvim-telescope/telescope.nvim', branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
	  'nvim-treesitter/nvim-treesitter',
	  run = ':TSUpdate'
	}

	use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
	    --- Uncomment the two plugins below if you want to manage the language servers from neovim
	    -- {'williamboman/mason.nvim'},
	    -- {'williamboman/mason-lspconfig.nvim'},

	    -- LSP Support
	    {'neovim/nvim-lspconfig'},
	    {'williamboman/mason.nvim'},
	    {'williamboman/mason-lspconfig.nvim'},
	    -- Autocompletion
	    {'hrsh7th/nvim-cmp'},
	    {'hrsh7th/cmp-nvim-lsp'},
	    {'L3MON4D3/LuaSnip'},
	  }
	}
end)

