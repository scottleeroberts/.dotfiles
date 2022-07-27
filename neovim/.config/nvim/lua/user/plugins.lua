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
  use "wbthomason/packer.nvim"
  use "/folke/tokyonight.nvim"
  use "FooSoft/vim-argwrap"
  use "alvan/vim-closetag"
  use "ap/vim-css-color"
  use "benmills/vimux"
  use "chrisbra/Recover.vim"
  use "christoomey/vim-tmux-navigator"
  use "digitaltoad/vim-pug"
  use "jiangmiao/auto-pairs"
  use { "junegunn/fzf", run = ":call fzf#install()" }
  use "junegunn/fzf.vim"
  use "kchmck/vim-coffee-script"
  use "kthibodeaux/tig.vim"
  use "lisinge/vim-slim"
  use { 'neoclide/coc.nvim', branch = 'release' }
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-telescope/telescope-fzy-native.nvim"
  use "nvim-telescope/telescope.nvim"
  use "nvim-treesitter/nvim-treesitter"
  use "pangloss/vim-javascript"
  use "posva/vim-vue"
  use "ryanoasis/vim-devicons"
  use "slm-lang/vim-slm"
  use "thoughtbot/vim-rspec"
  use "tpope/vim-abolish"
  use "tpope/vim-endwise"
  use "tpope/vim-rails"
  use "tpope/vim-repeat"
  use "tpope/vim-surround"
  use "tyru/caw.vim"
  use "unblevable/quick-scope"
  use "vim-ruby/vim-ruby"
  use "voldikss/vim-floaterm"
  use "wellle/targets.vim"
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use "lewis6991/gitsigns.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
