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
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    keys = {
      { "gf", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to Definition" },
      { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to Definition" },
      { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Go to Implementation" },
      { "<leader>ll", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "LSP Diagnostics" },
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
      { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover Documentation" },
      { "<leader>ld", "<c-]>", desc = "Go to Definition (ctags fallback)" },
      { "<leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
    },
    config = function()
      -- Configure LSP servers with custom settings
      vim.lsp.config("gopls", require("user.lsp.gopls"))
      vim.lsp.config("ruby_lsp", require("user.lsp.ruby_lsp"))
      vim.lsp.config("ts_ls", require("user.lsp.ts_ls"))
      vim.lsp.config("lua_ls", require("user.lsp.lua_ls"))
      vim.lsp.config("rubocop", require("user.lsp.rubocop"))
      vim.lsp.config("golangci_lint_ls", require("user.lsp.golangci_lint_ls"))

      -- Enable LSP servers
      vim.lsp.enable("golangci_lint_ls")
      vim.lsp.enable("gopls")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("rubocop")
      vim.lsp.enable("ruby_lsp")
      vim.lsp.enable("ts_ls")
      -- Note: copilot LSP is managed by copilot.lua plugin, not here
    end,
  },
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
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
