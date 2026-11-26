-- Treesitter and related plugins
-- Parser installation handled by ts-install.nvim.
-- Highlighting, indentation, and folding use Neovim 0.12 built-in APIs
-- (configured in config/treesitter.lua).
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    init = function()
      vim.g.loaded_nvim_treesitter = 1 -- prevent built-in setup, only used for parser registry
    end,
  },
  {
    "lewis6991/ts-install.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    opts = {
      ensure_install = require("user.config.treesitter").languages,
      auto_install = true,
    },
    config = function(_, opts)
      if vim.env.DOTFILES_NVIM_MODE then
        -- Setup and verification manage parser installation explicitly.
        opts = vim.tbl_extend("force", opts, { ensure_install = {}, auto_install = false, auto_update = false })
      end
      require("ts-install").setup(opts)
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup({
        color = "#AA33AA",
        hl_priority = 1000,
      })
    end,
  },
}
