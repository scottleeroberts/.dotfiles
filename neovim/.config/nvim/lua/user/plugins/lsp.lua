-- LSP and completion plugins
return {
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUpdate",
    },
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "saghen/blink.cmp",
    config = function()
      require("blink.cmp").setup({
        keymap = { preset = "enter" },
        completion = {
          documentation = { auto_show = true },
        },
        sources = {
          default = { "lsp", "path", "buffer" },
        },
        fuzzy = { implementation = "lua" },
        signature = { enabled = true },
      })
    end,
  },
}
