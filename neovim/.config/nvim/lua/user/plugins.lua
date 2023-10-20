local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
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

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Install your plugins here
return packer.startup(function(use)
  use "andymass/vim-matchup"
  use "EdenEast/nightfox.nvim"
  use "FooSoft/vim-argwrap"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "alvan/vim-closetag"
  use "benmills/vimux"
  use "chrisbra/Recover.vim"
  use "christoomey/vim-tmux-navigator"
  use "folke/tokyonight.nvim"
  use "github/copilot.vim"
  use "kthibodeaux/tig.vim"
  use "lewis6991/gitsigns.nvim"
  use "nvim-treesitter/nvim-treesitter"
  use "rebelot/kanagawa.nvim"
  use "scottleeroberts/rosepine.nvim"
  use "thoughtbot/vim-rspec"
  use "tpope/vim-commentary"
  use "tpope/vim-endwise"
  use "tpope/vim-rails"
  use "tpope/vim-repeat"
  use "tpope/vim-surround"
  use "unblevable/quick-scope"
  use "voldikss/vim-floaterm"
  use "wbthomason/packer.nvim"
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    "lukas-reineke/indent-blankline.nvim",
  }
  use {
    'folke/noice.nvim',
    requires = {
      "MunifTanjim/nui.nvim","rcarriga/nvim-notify",
    }
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'hrsh7th/cmp-cmdline'},         -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional
      {'hrsh7th/cmp-emoji'},     -- Optional
    }
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
