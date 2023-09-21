local lsp = require("lsp-zero").preset({"recommended"})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

--mappings
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<Enter>'] = cmp.mapping.confirm({ select = true }),
})
lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})
lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)
lsp.setup()

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "emoji", option = { insert = true } },
  }),
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- diagnostics errors are not done as virtual text (ie inline)
vim.diagnostic.config({
    virtual_text = false
})
