-- Terminal and TMUX integration plugins
return {
  {
    "benmills/vimux",
    keys = {
      { "<leader>vp", "<cmd>VimuxPromptCommand<cr>", desc = "Vimux Prompt" },
      { "<leader>vl", "<cmd>VimuxRunLastCommand<cr>", desc = "Vimux Run Last" },
      { "<leader>vi", "<cmd>VimuxInspectRunner<cr>", desc = "Vimux Inspect" },
      { "<leader>vz", "<cmd>VimuxZoomRunner<cr>", desc = "Vimux Zoom" },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      -- Disable default keymaps so we can set our own in keymaps.lua
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext" },
    keys = {
      { "<leader>ft", "<cmd>FloatermToggle<cr>", desc = "Toggle Floaterm" },
    },
  },
  {
    "chrisbra/Recover.vim",
    event = "BufReadPost",
  },
}
