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
      nes = { enabled = false },
      cli = {
        picker = "snacks",
        tools = {
          claude = { cmd = { "claude" } },
        },
      },
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
          require("sidekick.cli").toggle({ name = "claude" })
        end,
        desc = "Sidekick Toggle Claude",
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").send({ msg = "{position}" })
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
          local Session = require("sidekick.cli.session")
          local Terminal = require("sidekick.cli.terminal")
          local Config = require("sidekick.config")

          Session.setup() -- Ensure backends are registered

          local tool = Config.get_tool("claude"):clone({ cmd = { "claude", "--resume" } })
          local terminal = Terminal.new({ tool = tool })
          terminal:show()
          terminal:focus()
        end,
        desc = "Resume Claude Session",
      },
      {
        "<C-k>",
        function()
          local chan = vim.bo.channel
          if chan then
            vim.api.nvim_chan_send(chan, "\x11") -- \x11 is Ctrl-Q
          end
        end,
        mode = "t",
        desc = "break into scrolly mode in terminal",
      },
    },
  },
}
