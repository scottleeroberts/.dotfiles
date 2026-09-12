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
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    lazy = false,
    opts = {
      -- ts-install.nvim needs the tree-sitter CLI to build parsers
      ensure_installed = { "tree-sitter-cli" },
    },
  },
  {
    "SmiteshP/nvim-navic",
    opts = {
      lsp = { auto_attach = true },
      highlight = false,
      separator = " > ",
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = { "saghen/blink.lib" },
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
