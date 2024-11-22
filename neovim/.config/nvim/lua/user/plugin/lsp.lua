local lsp = require("lsp-zero").preset({"recommended"})
local cmp = require('cmp')

-- Mappings
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<Enter>'] = cmp.mapping.confirm({ select = true }),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
    if vim.api.nvim_buf_get_option(bufnr, 'filetype') ~= 'cucumber' then
        lsp.buffer_autoformat()
    end
end)

lsp.setup()

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "codeium" },
    { name = "emoji", option = { insert = true } },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})

-- Disable inline virtual text for diagnostics errors
vim.diagnostic.config({
    virtual_text = false
})
