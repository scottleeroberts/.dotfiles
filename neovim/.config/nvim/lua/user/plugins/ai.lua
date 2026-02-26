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
    -- Patch sidekick's terminal readiness detection to be less aggressive.
    -- Claude Code's dynamic status line keeps changing the terminal line count during
    -- startup, which resets the stability check and forces a full 5s timeout before
    -- the send queue is processed and input is accepted.
    -- See: https://github.com/folke/sidekick.nvim/issues/150
    build = function()
      local path = vim.fn.stdpath("data")
        .. "/lazy/sidekick.nvim/lua/sidekick/cli/terminal.lua"
      local f = io.open(path, "r")
      if not f then return end
      local content = f:read("*a")
      f:close()
      content = content:gsub("READY_MAX_WAIT = %d+", "READY_MAX_WAIT = 500")
      content = content:gsub("READY_CHECK_INTERVAL = %d+", "READY_CHECK_INTERVAL = 200")
      content = content:gsub("READY_INIT_DELAY = %d+", "READY_INIT_DELAY = 200")
      f = io.open(path, "w")
      if not f then return end
      f:write(content)
      f:close()
    end,
    opts = {
      nes = { enabled = false },
      cli = {
        default = "claude",
        picker = "snacks",
        tools = {
          claude = { cmd = { "claude" }, env = { NVIM = false } },
          aider = { enabled = false },
          amazon_q = { enabled = false },
          codex = { enabled = false },
          copilot = { enabled = false },
          crush = { enabled = false },
          cursor = { enabled = false },
          gemini = { enabled = false },
          grok = { enabled = false },
          opencode = { enabled = false },
          qwen = { enabled = false },
        },
      },
    },
    keys = {
      {
        "<leader>at",
        function()
          local Session = require("sidekick.cli.session")
          local Terminal = require("sidekick.cli.terminal")
          local Config = require("sidekick.config")

          Session.setup()

          local tool = Config.get_tool("claude"):clone()
          local terminal = Terminal.new({ tool = tool })
          terminal:show()
          terminal:focus()
        end,
        desc = "Start New Claude Session",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select({ filter = { name = "claude" } })
        end,
        desc = "Sidekick Select Claude",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Sidekick Close Claude",
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
