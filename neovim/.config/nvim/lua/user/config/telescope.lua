-- Telescope configuration
local actions = require("telescope.actions")

require("telescope").setup({
  pickers = {
    git_bcommits = {
      git_command = { "git", "log", "--pretty=%h %an |require %s (%cr)", "--abbrev-commit", "--follow", "--" },
    },
    git_commits = {
      git_command = { "git", "log", "--pretty=%h %an %s (%cr)", "--abbrev-commit" },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
    mappings = {
      i = {
        ["<esc>"] = "close",
        ["<C-q>"] = function(prompt_bufnr)
          actions.send_selected_to_qflist(prompt_bufnr)
          vim.cmd("copen")
        end,
      },
      n = {
        ["<C-q>"] = function(prompt_bufnr)
          actions.send_selected_to_qflist(prompt_bufnr)
          vim.cmd("copen")
        end,
      },
    },
    layout_strategy = "flex",
    layout_config = {
      preview_cutoff = 10,
      width = 0.8,
      height = 0.9,
      flex = {
        flip_columns = 170,
      },
    },
    preview = {
      treesitter = false, -- disabled: workaround for nvim 0.12 highlighter nil node bug
    },
    sorting_strategy = "descending",
    dynamic_preview_title = true,
    prompt_prefix = "🔍 ",
    selection_caret = "➜ ",
    border = true,
    winblend = 0,
    color_devicons = true,
  },
})

-- Load extensions
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")

-- Custom telescope border highlight
vim.cmd([[highlight TelescopeBorder guibg=NONE ctermbg=NONE]])
