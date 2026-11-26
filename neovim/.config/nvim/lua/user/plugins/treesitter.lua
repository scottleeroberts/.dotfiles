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
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        move = { set_jumps = true },
      })
    end,
    keys = {
      {
        "<leader>js",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
        end,
        desc = "Jump to start of next function",
      },
      {
        "<leader>je",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
        end,
        desc = "Jump to end of next function",
      },
    },
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
