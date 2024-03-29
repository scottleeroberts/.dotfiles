require("nvim-tree").setup {
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
        default = "",
        symlink = "",
        folder = {
          arrow_open = '',
          arrow_closed = '',
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
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
}
