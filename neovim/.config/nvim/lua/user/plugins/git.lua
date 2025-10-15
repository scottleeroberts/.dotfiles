-- Git integration plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>gc", "<cmd>Gitsigns blame_line<cr>", desc = "Git Blame Line" },
      { "<leader>gv", "<cmd>Gitsigns blame<cr>", desc = "Git Blame" },
    },
    config = function()
      require("user.config.gitsigns")
    end,
  },
  {
    "kthibodeaux/tig.vim",
    cmd = { "Tig", "TigBlame", "TigOpenCurrentFile" },
  },
  {
    "rhysd/committia.vim",
    ft = "gitcommit",
  },
}
