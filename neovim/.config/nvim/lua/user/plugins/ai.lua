-- AI assistant plugins

-- Ensure a claude terminal exists and is visible, bypassing sidekick's picker.
-- Returns the terminal for direct sending via vim.api.nvim_chan_send(t.job, ...).
local function ensure_claude_visible()
  local Cli = require("sidekick.cli")
  local Config = require("sidekick.config")
  local Terminal = require("sidekick.cli.terminal")

  for _, t in ipairs(Cli.get_terminals({ name = "claude" })) do
    if not t.closed and t:is_running() then
      t:show()
      t:focus()
      return t
    end
  end

  local tool = vim.deepcopy(Config.cli.tools["claude"])
  tool.name = "claude"
  local terminal = Terminal.new(tool)
  terminal:show()
  terminal:focus()
  return terminal
end

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
        "<leader>aa",
        function()
          local mode = vim.fn.mode()
          local file = vim.fn.expand("%:.")
          local range
          if mode == "v" or mode == "V" or mode == "\22" then
            range = vim.fn.line("v") .. "-" .. vim.fn.line(".")
          else
            range = tostring(vim.fn.line("."))
          end

          local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
          vim.api.nvim_feedkeys(esc, "nx", false)
          local t = ensure_claude_visible()

          if file ~= "" and t and t.job then
            vim.api.nvim_chan_send(t.job, file .. ":" .. range .. " ")
          end
        end,
        mode = { "n", "x" },
        desc = "Send file:line to Claude",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select({ filter = { name = "claude" } })
        end,
        desc = "Sidekick Select Claude",
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
