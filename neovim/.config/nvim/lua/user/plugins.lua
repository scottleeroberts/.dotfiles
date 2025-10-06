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
  -- Colorschemes
  "EdenEast/nightfox.nvim",
  "folke/tokyonight.nvim",
  "rebelot/kanagawa.nvim",
  "scottleeroberts/rosepine.nvim",
  "oxfist/night-owl.nvim",

  -- Treesitter
  "nvim-treesitter/nvim-treesitter",
  "JoosepAlviste/nvim-ts-context-commentstring",
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },

  -- Navigation & Search
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- File Management
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  "stevearc/oil.nvim",

  -- Git
  "lewis6991/gitsigns.nvim",
  "kthibodeaux/tig.vim",
  "rhysd/committia.vim",

  -- LSP & Completion
  { "williamboman/mason.nvim" },
  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot" },
    config = function()
      require('blink.cmp').setup {
        keymap = { preset = 'enter' },
        completion = { documentation = { auto_show = true } },
        sources = {
          default = { 'lsp', 'path', 'buffer', 'copilot' },
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

  -- AI Assistants
  "zbirenbaum/copilot.lua",
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
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
        question_header = " You:",
        answer_header   = " Copilot:",
      })
    end,
  },

  -- UI Enhancements
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  "lukas-reineke/indent-blankline.nvim",

  -- Markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('render-markdown').setup({
        code = { disable_background = true },
      })
    end,
  },

  -- Editing & Text Objects
  "andymass/vim-matchup",
  "FooSoft/vim-argwrap",
  "tpope/vim-endwise",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "unblevable/quick-scope",

  -- Terminal & TMUX
  "benmills/vimux",
  "christoomey/vim-tmux-navigator",
  "voldikss/vim-floaterm",

  -- Utilities
  "chrisbra/Recover.vim",
})
