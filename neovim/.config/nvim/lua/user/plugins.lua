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
  use "tpope/vim-endwise"
  use "tpope/vim-repeat"
  use "tpope/vim-surround"
  use "unblevable/quick-scope"
  use "voldikss/vim-floaterm"
  use "wbthomason/packer.nvim"
  use "oxfist/night-owl.nvim"
  use "rhysd/committia.vim"
  use 'stevearc/oil.nvim'
  use "lukas-reineke/indent-blankline.nvim"

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {
    'folke/noice.nvim',
    requires = {
      "MunifTanjim/nui.nvim", "rcarriga/nvim-notify",
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
    'williamboman/mason.nvim',
  }

  use {
    'saghen/blink.cmp',
    requires = {
      'fang2hou/blink-copilot',
    },
    config = function()
      require('blink.cmp').setup {
        keymap = { preset = 'enter' },
        completion = { documentation = { auto_show = true } },
        sources = {
          default = {'lsp', 'path', 'buffer', 'copilot' },
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-copilot",
              score_offset = 100,
              async = true,
            },
          },
        },
        fuzzy = { implementation = 'lua' },
        signature = { enabled = true },
      }
    end,
  }

  use({
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },   -- if you prefer nvim-web-devicons
    config = function()
      require('render-markdown').setup({})
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
