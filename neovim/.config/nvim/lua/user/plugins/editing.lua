-- Editing and text object plugins
return {
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "FooSoft/vim-argwrap",
    keys = {
      { "<leader>a", "<cmd>ArgWrap<cr>", desc = "Argument Wrap" },
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
