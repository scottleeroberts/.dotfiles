-- AI assistant plugins
return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-l>",
          },
        },
        panel = { enabled = false },
        filetypes = { VimspectorPrompt = false },
      })
    end,
  },
  {
    "folke/sidekick.nvim",
    opts = {
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").toggle("claude")
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      {
        "<leader>ar",
        function()
          local Terminal = require("sidekick.cli.terminal")
          local Config = require("sidekick.config")
          local tool = vim.deepcopy(Config.cli.tools["claude"])
          tool.name = "claude"
          table.insert(tool.cmd, "--resume")

          local terminal = Terminal.new(tool)
          terminal:show()
          terminal:focus()
        end,
        desc = "Resume Claude Session",
      },
    },
  },
}
