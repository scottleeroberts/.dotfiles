-- Markdown rendering plugins
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("render-markdown").setup({
        code = { disable_background = true },
      })
    end,
  },
}
