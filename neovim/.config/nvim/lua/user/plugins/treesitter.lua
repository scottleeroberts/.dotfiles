-- Treesitter and related plugins
--
-- NOTE: nvim-treesitter was archived on 2026-04-03. The `main` branch has a
-- breaking rewrite for Neovim 0.12 (new API, requires tree-sitter CLI).
-- Pinned to `master` (frozen, old API) until we migrate.
-- Migration options:
--   1. Archived repo `main` branch + lewis6991/ts-install.nvim for auto-install
--   2. Community fork: neovim-treesitter/nvim-treesitter (too new as of 2026-04-08)
-- Telescope treesitter preview is disabled (config/telescope.lua) as a workaround
-- for a nil node bug in the 0.12 highlighter.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("user.config.treesitter")
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false, -- disable CursorHold autocmd, fixes nil language_tree crash
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    'm-demare/hlargs.nvim',
    config = function()
      require('hlargs').setup({
        color = '#AA33AA',
        hl_priority = 1000,
      })
    end,
  },
}
