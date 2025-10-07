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
    config = function()
      require('blink.cmp').setup {
        keymap = { preset = 'enter' },
        completion = { documentation = { auto_show = true } },
        sources = {
          default = { 'lsp', 'path', 'buffer' },
        },
        fuzzy = { implementation = 'lua' },
        signature = { enabled = true },
      }
    end,
  },

  -- AI Assistants
  "zbirenbaum/copilot.lua",
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle("claude") end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function() require("sidekick.cli").select({ filter = { installed = true
       } }) end,
        desc = "Select CLI",
      },
      {
        "<leader>at",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>av",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
    },
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
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      -- Disable default keymaps so we can set our own in keymaps.lua
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
  "voldikss/vim-floaterm",

  -- Utilities
  "chrisbra/Recover.vim",
})
