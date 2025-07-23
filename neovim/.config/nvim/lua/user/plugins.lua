-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "andymass/vim-matchup",
  "EdenEast/nightfox.nvim",
  "FooSoft/vim-argwrap",
  "JoosepAlviste/nvim-ts-context-commentstring",
  "alvan/vim-closetag",
  "benmills/vimux",
  "chrisbra/Recover.vim",
  "christoomey/vim-tmux-navigator",
  "folke/tokyonight.nvim",
  "github/copilot.vim",
  "kthibodeaux/tig.vim",
  "lewis6991/gitsigns.nvim",
  "nvim-treesitter/nvim-treesitter",
  "rebelot/kanagawa.nvim",
  "scottleeroberts/rosepine.nvim",
  "tpope/vim-endwise",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "unblevable/quick-scope",
  "voldikss/vim-floaterm",
  "wbthomason/packer.nvim",
  "oxfist/night-owl.nvim",
  "rhysd/committia.vim",
  "stevearc/oil.nvim",
  "lukas-reineke/indent-blankline.nvim",

  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim", "rcarriga/nvim-notify",
    }
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  { "williamboman/mason.nvim" },

  {
    "saghen/blink.cmp",
    dependencies = {
      "fang2hou/blink-copilot",
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
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('render-markdown').setup({})
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    build = "make tiktoken",
    config = function()
      require("CopilotChat").setup({
        mappings = {
          reset = {
            insert = "<c-.>",
            normal = "<Leader>c",
          },
        },
        question_header = " You:",
        answer_header   = " Copilot:",
      })
    end,
  },
})
