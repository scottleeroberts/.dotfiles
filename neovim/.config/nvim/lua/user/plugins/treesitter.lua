-- Treesitter and related plugins
-- NOTE: nvim-treesitter archived on 2026-04-03. Pinned to `master` (frozen,
-- old API) since `main` has a breaking rewrite requiring tree-sitter CLI.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("user.config.treesitter")
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false, -- disable CursorHold autocmd, fixes nil language_tree crash
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    'm-demare/hlargs.nvim',
    config = function()
      require('hlargs').setup({
        color = '#AA33AA',
        hl_priority = 1000,
      })
    end,
  },
}
