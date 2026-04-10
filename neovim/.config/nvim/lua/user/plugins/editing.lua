-- Editing and text object plugins
return {
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "FooSoft/vim-argwrap",
    keys = {
      { "<leader>aw", "<cmd>ArgWrap<cr>", desc = "Argument Wrap" },
    },
  },
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ae", "<cmd>AerialToggle!<cr>", desc = "Aerial (Symbol Outline)" },
    },
    opts = {
      layout = { default_direction = "right" },
      filter_kind = { "Class", "Constructor", "Enum", "Function", "Interface", "Method", "Module", "Struct" },
    },
  },
  {
    "tpope/vim-endwise",
    event = "InsertEnter",
  },
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "unblevable/quick-scope",
    keys = { "f", "F", "t", "T" },
  },
}
