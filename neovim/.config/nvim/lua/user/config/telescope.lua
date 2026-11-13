-- Telescope configuration
local actions = require("telescope.actions")

require("telescope").setup({
  pickers = {
    git_bcommits = {
      git_command = { "git", "log", "--pretty=%h %an %s (%cr)", "--abbrev-commit", "--follow", "--" },
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
    path_display = { "filename_first" },
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
        -- Send the Tab-selected entries, or all results when none are selected.
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
      n = {
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
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
    dynamic_preview_title = true,
    prompt_prefix = "🔍 ",
    selection_caret = "➜ ",
  },
})

-- Load extensions
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
require("git-worktree").setup()
require("telescope").load_extension("git_worktree")

-- Custom telescope border highlight
vim.cmd([[highlight TelescopeBorder guibg=NONE ctermbg=NONE]])
