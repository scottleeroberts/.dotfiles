-- Treesitter and related plugins
-- Parser installation handled by ts-install.nvim.
-- Highlighting, indentation, and folding use Neovim 0.12 built-in APIs
-- (configured in config/treesitter.lua).
return {
  {
    "lewis6991/ts-install.nvim",
    lazy = false,
    opts = {
      ensure_install = {
        "diff",
        "git_rebase",
        "gitcommit",
        "go",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "proto",
        "ruby",
        "vim",
        "vue",
      },
      auto_install = true,
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup({
        color = "#AA33AA",
        hl_priority = 1000,
      })
    end,
  },
}
