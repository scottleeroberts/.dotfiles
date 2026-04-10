-- Noice configuration
require("noice").setup({
  background_colour = "#222222",
  messages = { enabled = false },
  notifications = { enabled = false },
  lsp = {
    progress = {
      enabled = true,
      format = "lsp_progress",
      throttle = 1000 / 30,
      view = "mini",
    },
    override = {},
  },
  presets = {
    bottom_search = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
    command_palette = true,
  },
  views = {
    cmdline_popup = {
      position = { row = vim.o.lines * 0.32, col = "50%" },
      size = { width = 60, height = "auto" },
    },
    popupmenu = {
      position = { row = vim.o.lines * 0.32 + 3, col = "50%" },
      size = { width = 60, height = 10 },
      border = { style = "rounded", padding = { 0, 1 } },
      win_options = {
        winhighlight = {
          Normal = "Normal",
          FloatBorder = "DiagnosticInfo",
        },
      },
    },
  },
})
