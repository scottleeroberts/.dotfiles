-- Keybinding discovery and documentation
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>a", group = "AI" },
        { "<leader>b", group = "Buffers" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>m", group = "Migrations" },
        { "<leader>r", group = "Run Tests" },
        { "<leader>v", group = "Vimux" },
      },
    },
  },
}
