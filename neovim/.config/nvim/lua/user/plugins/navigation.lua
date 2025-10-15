-- Navigation, search, and file management plugins
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
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
          preview = true,
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
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        hijack_directories = {
          enable = false,
        },
        filters = {
          custom = { ".git" },
          exclude = { ".gitignore" },
        },
        update_cwd = true,
        renderer = {
          add_trailing = false,
          group_empty = true,
          highlight_git = false,
          root_folder_modifier = ":t",
          icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              git = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                arrow_open = "",
                arrow_closed = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "",
                staged = "S",
                unmerged = "",
                renamed = "➜",
                untracked = "U",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
          ignore_list = {},
        },
        git = {
          enable = true,
          timeout = 500,
        },
        view = {
          adaptive_size = false,
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    config = function()
      require("oil").setup()
    end,
  },
}
