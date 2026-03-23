-- Markdown rendering plugins
return {
  -- In-buffer markdown rendering (headings, bullets, tables, etc.)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("render-markdown").setup({
        heading = {
          sign = false,
          icons = { '# ', '## ', '### ', '#### ', '##### ', '###### ' },
          width = 'block',
          left_pad = 1,
          right_pad = 1,
        },
        code = {
          disable_background = true,
          sign = false,
          border = 'thin',
          width = 'block',
        },
        sign = { enabled = false },
        anti_conceal = {
          enabled = true,
          above = 1,
          below = 1,
        },
      })
    end,
  },

  -- Browser-based markdown preview with Mermaid diagram support
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_theme = "dark"
      -- Auto-close preview when switching buffers
      vim.g.mkdp_auto_close = 1
      -- Refresh on save (not continuous)
      vim.g.mkdp_refresh_slow = 1
      -- Don't auto-start
      vim.g.mkdp_auto_start = 0

      -- Set buffer-local keymap for markdown files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.api.nvim_buf_set_keymap(0, 'n', '<leader>md', ':MarkdownPreviewToggle<CR>',
            { noremap = true, silent = false, desc = 'Toggle markdown preview' })
        end,
      })
    end,
  },
}
