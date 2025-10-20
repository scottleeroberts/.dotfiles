-- Terminal and TMUX integration plugins
return {
  {
    "benmills/vimux",
    lazy = false,
    keys = {
      { "<leader>vp", "<cmd>VimuxPromptCommand<cr>", desc = "Vimux Prompt" },
      { "<leader>vl", "<cmd>VimuxRunLastCommand<cr>", desc = "Vimux Run Last" },
      { "<leader>vi", "<cmd>VimuxInspectRunner<cr>", desc = "Vimux Inspect" },
      { "<leader>vz", "<cmd>VimuxZoomRunner<cr>", desc = "Vimux Zoom" },
      -- Test runner keys (loads Vimux for test execution)
      { "<leader>rr", desc = "Run nearest test" },
      { "<leader>rf", desc = "Run test file" },
      { "<leader>ra", desc = "Run all tests" },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "t" }, desc = "Tmux Navigate Left" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "t" }, desc = "Tmux Navigate Down" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "t" }, desc = "Tmux Navigate Up" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "t" }, desc = "Tmux Navigate Right" },
    },
    init = function()
      -- Disable default keymaps so we define our own
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext" },
    keys = {
      { "<leader>tt", "<cmd>FloatermToggle<cr>", mode = { "n", "t" }, desc = "Toggle Floaterm" },
    },
  },
  {
    "chrisbra/Recover.vim",
    event = "BufReadPost",
  },
}
