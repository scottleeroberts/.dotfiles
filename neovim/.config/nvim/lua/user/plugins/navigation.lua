-- Navigation, search, and file management plugins
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "ThePrimeagen/git-worktree.nvim",
    },
    keys = {
      {
        "<leader>/",
        function()
          require("telescope.builtin").find_files({
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
            preview = { timeout = 1000 },
          })
        end,
        desc = "Find Files",
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").grep_string({
            use_regex = true,
            search = vim.fn.input("Grep For > "),
            vimgrep_arguments = { "rg", "--vimgrep", "--smart-case", "--hidden", "--glob", "!.git/**" },
          })
        end,
        desc = "Grep For String",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").grep_string({
            vimgrep_arguments = { "rg", "--vimgrep", "--hidden", "--glob", "!.git/**" },
          })
        end,
        desc = "Grep Current Word",
      },
      {
        "<leader>fg",
        "<cmd>Telescope live_grep<cr>",
        desc = "Live Grep",
      },
      {
        "<leader>bb",
        "<cmd>Telescope buffers<cr>",
        desc = "Buffers",
      },
      {
        "<leader>mi",
        function()
          require("telescope.builtin").find_files({
            sorting_strategy = "descending",
            cwd = "db/migrate",
            find_command = { "rg", "--files", "--hidden", "-g", "!.git", "--sortr=path" },
          })
        end,
        desc = "Find Migrations",
      },
      {
        "<leader>gc",
        "<cmd>Telescope git_commits<cr>",
        desc = "Git Commits",
      },
      {
        "<leader>gv",
        "<cmd>Telescope git_bcommits<cr>",
        desc = "Git Buffer Commits",
      },
      {
        "<leader>gs",
        "<cmd>Telescope git_stash<cr>",
        desc = "Git Stash",
      },
      {
        "<leader>gt",
        "<cmd>Telescope git_status<cr>",
        desc = "Git Status",
      },
      {
        "<leader>gq",
        "<cmd>Telescope quickfix<cr>",
        desc = "Quickfix",
      },
      {
        "<leader>gr",
        "<cmd>Telescope git_branches<cr>",
        desc = "Git Branches",
      },
      {
        "<leader>gw",
        function()
          require("telescope").extensions.git_worktree.git_worktrees()
        end,
        desc = "Git Worktrees",
      },
    },
    config = function()
      require("user.config.telescope")
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
    "ThePrimeagen/git-worktree.nvim",
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
    keys = {
      { "<c-n>", "<cmd>NvimTreeFocus<cr>", desc = "NvimTree Focus" },
    },
    config = function()
      require("user.config.nvim-tree")
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Oil File Browser" },
    },
    config = function()
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
}
