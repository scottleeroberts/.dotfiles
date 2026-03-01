vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH

local lsp_dir = vim.fn.stdpath('config') .. '/lsp/'
local servers = { 'golangci_lint_ls', 'gopls', 'lua_ls', 'rubocop', 'ruby_lsp', 'ts_ls' }
for _, server in ipairs(servers) do
  vim.lsp.config(server, dofile(lsp_dir .. server .. '.lua'))
end
vim.lsp.enable(servers)

function _G.navic_location()
  local navic = require("nvim-navic")
  local location = navic.is_available() and navic.get_location() or ""
  if vim.bo.filetype == "go" then
    local lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)
    for _, line in ipairs(lines) do
      local pkg = line:match("^package%s+(%S+)")
      if pkg then
        if location ~= "" then
          return pkg .. " > " .. location
        end
        return pkg
      end
    end
  end
  return location
end

local function set_statusline_italic()
  local sl = vim.api.nvim_get_hl(0, { name = "StatusLine", link = false })
  sl.italic = true
  vim.api.nvim_set_hl(0, "StatusLineItalic", sl)
end
set_statusline_italic()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_statusline_italic })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/documentSymbol") then
      vim.opt_local.statusline = " %f >>%#StatusLineItalic#%m %{%v:lua.navic_location()%}%#StatusLine# %= %l:%c "
    end
  end,
})

vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'Go to Definition' })
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'Go to Definition' })
vim.keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'Go to Definition' })
vim.keymap.set('n', '<leader>li', '<cmd>Telescope lsp_implementations<cr>', { desc = 'Go to Implementation' })
vim.keymap.set('n', '<leader>lr', '<cmd>Telescope lsp_references<cr>', { desc = 'References' })
vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Code Action' })
vim.keymap.set('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'Hover Documentation' })
vim.keymap.set('n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = 'LSP Diagnostics' })
vim.keymap.set('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>', { desc = 'Document Symbols' })
vim.keymap.set('n', '<leader>lw', '<cmd>Telescope lsp_workspace_symbols<cr>', { desc = 'Workspace Symbols' })
vim.keymap.set('n', '<leader>ln', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename' })
