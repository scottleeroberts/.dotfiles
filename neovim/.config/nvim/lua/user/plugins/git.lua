-- Git integration plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("user.config.gitsigns")
    end,
  },
  {
    "kthibodeaux/tig.vim",
    keys = {
      { "<leader>gb", "<Plug>TigBlame", desc = "Git Blame" },
    },
  },
  {
    "rhysd/committia.vim",
    ft = "gitcommit",
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
    keys = {
      { "<leader>gd", ":DiffviewOpen<CR>", desc = "Diff View" },
    },
  },
}
