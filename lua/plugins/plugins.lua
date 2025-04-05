local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	use {'wbthomason/packer.nvim'}

	-- LSP --
	use {'williamboman/mason.nvim'}
	use {'williamboman/mason-lspconfig.nvim'}
	use {'neovim/nvim-lspconfig'}

	-- SNIPPETS --
	use {'saadparwaiz1/cmp_luasnip'}
	use {"L3MON4D3/LuaSnip"}
	use {'rafamadriz/friendly-snippets'}

	-- CMP --
	use {'hrsh7th/nvim-cmp'}
	use {'hrsh7th/cmp-nvim-lsp'}
	use {'hrsh7th/cmp-buffer'}
	use {'hrsh7th/cmp-path'}
	use {'hrsh7th/cmp-cmdline'}
	use {'hrsh7th/cmp-nvim-lsp-signature-help'}
	use {'hrsh7th/cmp-nvim-lsp-document-symbol'}

  -- DAP --
  use {'mfussenegger/nvim-dap'}
  use {
    'rcarriga/nvim-dap-ui',
    requires = {
      "mfussenegger/nvim-dap", 
      "nvim-neotest/nvim-nio"
    }
  }
  use {'theHamsta/nvim-dap-virtual-text'}

  -- FORMATTER --
  use {
    'nvimtools/none-ls.nvim',
    requires = {'nvim-lua/plenary.nvim'}
  }

	-- TELESCOPES --
	use {
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.8', 
		requires = {'nvim-lua/plenary.nvim'}
	}

	-- THEMES --
	use {'projekt0n/github-nvim-theme'}
	use {'cpea2506/one_monokai.nvim'}
	use {'olimorris/onedarkpro.nvim'}
	use {'Mofiqul/vscode.nvim'}
	use {'folke/tokyonight.nvim'}

	-- STATUSLINE --
	use {
		'nvim-lualine/lualine.nvim',
		requires = {'nvim-tree/nvim-web-devicons'}
	}

	-- NVIM TREE --
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {'nvim-tree/nvim-web-devicons'}
	}

  -- AUTOPAIRS --
  use {'windwp/nvim-autopairs'}

  -- TREESITTER --
  use {'nvim-treesitter/nvim-treesitter'}

  -- TMUX --
  use {'aserowy/tmux.nvim'}

  -- TERMINAL --
  use {'akinsho/toggleterm.nvim'}

  -- CMAKE --
  use {'Civitasv/cmake-tools.nvim'}
end)

