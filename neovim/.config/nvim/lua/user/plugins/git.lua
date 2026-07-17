-- Git integration plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("user.config.gitsigns")
    end,
  },
  {
    "kthibodeaux/tig.vim",
    keys = {
      { "<leader>gb", "<Plug>TigBlame", desc = "Git Blame" },
    },
  },
  {
    "rhysd/committia.vim",
    ft = "gitcommit",
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
    keys = {
      { "<leader>gd", ":DiffviewOpen<CR>", desc = "Diff View" },
      {
        "<leader>gp",
        function()
          local base
          for _, b in ipairs({ "main", "master", "develop" }) do
            vim.fn.system("git rev-parse --verify " .. b .. " 2>/dev/null")
            if vim.v.shell_error == 0 then
              base = b
              break
            end
          end
          if not base then
            vim.notify("Could not find base branch (main/master/develop)", vim.log.levels.ERROR)
            return
          end
          local merge_base = vim.fn.systemlist("git merge-base HEAD " .. base)[1]
          if not merge_base or merge_base == "" then
            vim.notify("Could not determine merge base with " .. base, vim.log.levels.ERROR)
            return
          end
          vim.cmd("DiffviewFileHistory --range=" .. merge_base .. "..HEAD")
        end,
        desc = "PR commit history",
      },
    },
  },
}
