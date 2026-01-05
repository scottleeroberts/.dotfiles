-- UI enhancement plugins
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = { enabled = true },
    },
    init = function()
      vim.ui.select = function(...)
        require("snacks").picker.ui_select(...)
      end
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("user.config.noice")
    end,
  },
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("ibl").setup({
        indent = { highlight = { "LineNr" }, char = "│" },
        scope = {
          show_start = false,
          show_end = false,
        },
      })
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 120,
        options = {
        signcolumn = "yes",
        number = true,
        relativenumber = true
        },
      },
    },
    keys = {
      {
        "<leader>z",
        function()
          require("zen-mode").toggle()
        end,
        desc = "Toggle Zen Mode",
      },
    },
  },
}
