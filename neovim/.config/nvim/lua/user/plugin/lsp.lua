local lsp = require("lsp-zero").preset({})
lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)
lsp.setup()

local cmp = require("cmp")
vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
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

vim.diagnostic.config({
    virtual_text = false
})
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float({scope="line"})]])
