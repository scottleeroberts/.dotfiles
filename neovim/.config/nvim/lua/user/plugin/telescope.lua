require("telescope").load_extension("ui-select")
local actions = require('telescope.actions')

local telescope = {}
require('telescope').setup{
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
      require("telescope.themes").get_dropdown {}
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
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
          ['<esc>'] = 'close',
          ["<C-q>"] = function(prompt_bufnr)
            actions.send_selected_to_qflist(prompt_bufnr)
            vim.cmd('copen')
          end,
        },
        n = {
          ["<C-q>"] = function(prompt_bufnr)
            actions.send_selected_to_qflist(prompt_bufnr)
            vim.cmd('copen')
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
      preview = true,
      sorting_strategy = "descending",
      dynamic_preview_title = true,
      prompt_prefix = "🔍 ",
      selection_caret = "➜ ",
      border = true,
      winblend=0,
      color_devicons = true,
   },
}
vim.cmd([[highlight TelescopeBorder guibg=NONE ctermbg=NONE]])
return telescope
