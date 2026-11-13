-- Navigation, search, and file management plugins
return {
  {
    -- Pickers. snacks.nvim itself is configured in plugins/ui.lua.
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>/",
        function()
          require("snacks").picker.files({ hidden = true, exclude = { ".git", "node_modules" } })
        end,
        desc = "Find Files",
      },
      {
        "<leader>ff",
        function()
          local search = vim.fn.input("Grep For > ")
          if search == "" then
            return
          end
          require("snacks").picker.grep({
            search = search,
            live = false,
            hidden = true,
            exclude = { "node_modules" },
          })
        end,
        desc = "Grep For String",
      },
      {
        "<leader>fs",
        function()
          require("snacks").picker.grep_word({ hidden = true, exclude = { "node_modules" } })
        end,
        mode = { "n", "x" },
        desc = "Grep Current Word",
      },
      {
        "<leader>fg",
        function()
          require("snacks").picker.grep({ hidden = true, exclude = { "node_modules" } })
        end,
        desc = "Live Grep",
      },
      { "<leader>bb", function() require("snacks").picker.buffers() end, desc = "Buffers" },
      {
        "<leader>mi",
        function()
          -- Newest migration first: keep rg's reverse path order, no re-sorting.
          require("snacks").picker.files({
            cwd = "db/migrate",
            hidden = true,
            exclude = { ".git" },
            args = { "--sortr=path" },
            matcher = { sort_empty = false },
          })
        end,
        desc = "Find Migrations",
      },
      { "<leader>gc", function() require("snacks").picker.git_log() end, desc = "Git Commits" },
      { "<leader>gv", function() require("snacks").picker.git_log_file() end, desc = "Git Buffer Commits" },
      { "<leader>gs", function() require("snacks").picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gt", function() require("snacks").picker.git_status() end, desc = "Git Status" },
      { "<leader>gq", function() require("snacks").picker.qflist() end, desc = "Quickfix" },
      { "<leader>gr", function() require("snacks").picker.git_branches() end, desc = "Git Branches" },
      {
        "<leader>gw",
        function()
          require("user.worktrees").pick()
        end,
        desc = "Git Worktrees",
      },
    },
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
